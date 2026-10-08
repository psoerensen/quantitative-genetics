# Teaching helpers shared by mouse Practicals 3-5; no package APIs.
mouse_file <- function(name, revision, checksum) {
  path <- file.path(tempdir(), paste0(name, ".rds"))
  if (!file.exists(path)) {
    url <- paste0("https://raw.githubusercontent.com/psoerensen/bgcourse/",
                  revision, "/data/", name, ".rds")
    download.file(url, path, mode = "wb", quiet = TRUE)
  }
  stopifnot(unname(tools::md5sum(path)) == checksum)
  readRDS(path)
}

mouse_pedigree_data <- function() {
  mouse <- mouse_file("mouseqtl", "224a4024f558ff9c0a481468979178e33b81b27b",
                      "88b7ab5e5d57a57d2e5526170be9f2c8")
  pedigree <- mouse_file("pedigree", "3c4ba74bf4f28a9716849827895db792dc2000b5",
                         "a1b650af27a30b2148bcabc2795b7dd0")
  # Convert the historical file's 0 sentinel to explicit missing parentage.
  pedigree$id <- as.character(pedigree$id)
  for (parent in c("sire", "dam")) {
    pedigree[[parent]] <- as.character(pedigree[[parent]])
    pedigree[[parent]][pedigree[[parent]] == "0"] <- NA_character_
  }
  stopifnot(!anyNA(pedigree$id), !anyDuplicated(pedigree$id),
            !anyDuplicated(rownames(mouse)))
  mouse <- mouse[complete.cases(mouse[c("BW", "sex", "reps")]), ]
  ids <- rownames(mouse)
  where <- match(ids, pedigree$id)
  stopifnot(!anyNA(where),
            identical(as.character(mouse$sire), pedigree$sire[where]),
            identical(as.character(mouse$dam), pedigree$dam[where]))
  list(mouse = mouse, pedigree = pedigree, ids = ids)
}

# Tabular additive relationship recursion, assuming unrelated, noninbred
# founders and parents preceding offspring. Dense matrices are for this
# small teaching dataset, not a large-population workflow.
mouse_relationship <- function(pedigree) {
  n <- nrow(pedigree)
  s <- match(pedigree$sire, pedigree$id)
  d <- match(pedigree$dam, pedigree$id)
  stopifnot(n > 0L, !anyDuplicated(pedigree$id),
            all(is.na(pedigree$sire) | !is.na(s)),
            all(is.na(pedigree$dam) | !is.na(d)),
            all(is.na(s) | s < seq_len(n)),
            all(is.na(d) | d < seq_len(n)))
  A <- matrix(0, n, n, dimnames = list(pedigree$id, pedigree$id))
  for (i in seq_len(n)) {
    previous <- seq_len(i - 1L)
    if (!is.na(s[i])) A[i, previous] <- A[i, previous] + A[s[i], previous]/2
    if (!is.na(d[i])) A[i, previous] <- A[i, previous] + A[d[i], previous]/2
    A[previous, i] <- A[i, previous]
    A[i, i] <- 1
    if (!is.na(s[i]) && !is.na(d[i])) A[i, i] <- 1 + A[s[i], d[i]]/2
  }
  A
}

mouse_fit <- function(y, X, K, label) {
  stopifnot(requireNamespace("qgg", quietly = TRUE),
            identical(rownames(K), rownames(X)),
            identical(colnames(K), rownames(X)),
            length(y) == nrow(X), qr(X)$rank == ncol(X),
            isTRUE(all.equal(K, t(K), tolerance = 1e-10)))
  fit <- qgg::greml(y = y, X = X, GRM = setNames(list(K), label),
                    maxit = 100, ncores = 1)
  stopifnot(fit$niter < 100, all(is.finite(fit$theta)), all(fit$theta > 0))
  fit
}
