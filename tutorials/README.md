# Tutorials

See the [course map](course_map.qmd) for prerequisites and routes through both course sequences.

- [Exploring quantitative traits in a mouse population](mouse_quantitative_traits.qmd): Practical 1, using base R and a pinned public dataset.
- [From genotype effects to quantitative variation](mouse_single_locus.qmd): Practical 2, with corrected dominance coding and explicit HWE model assumptions.

- [Estimating genetic parameters](mouse_genetic_parameters.qmd): Practical 3.
- [Predicting pedigree breeding values](mouse_pedigree_breeding_values.qmd): Practical 4.
- [Predicting genomic breeding values](mouse_genomic_breeding_values.qmd): Practical 5.

- [Breeding objectives and selection indices](breeding_objectives_indices.qmd): Practical 6, using base R and hypothetical covariance inputs.

- [Selection policies and mating plans](selection_mating_plans.qmd): Practical 7, requiring gsim for selection and parentage mechanics.

- [Simulating selection response](simulating_selection_response.qmd): Practical 8, using gsim and a synthetic phased panel without downloads.

- [Relationships, mating and inbreeding](relationships_mating_inbreeding.qmd): Practical 9, using base R and the existing relationship helper on a hypothetical pedigree.

- [Validating predictions and selection decisions](validating_selection_predictions.qmd): Practical 10, using base R and known synthetic truth to distinguish validation targets.

- [Comparing breeding programmes](comparing_breeding_programmes.qmd): Practical 11, a small paired gsim comparison of recording policies with fixed bases and explicit resources.

Practicals 3–5 require qgg and the shared script in scripts/mouse_practical_helpers.R.

Render an individual page from the repository root, for example:

```text
quarto render tutorials/mouse_single_locus.qmd
```
