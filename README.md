# Quantitative Genetics

Standalone Quarto- and R-based teaching materials for quantitative genetics.

Published website: <https://psoerensen.github.io/quantitative-genetics/>

Teaching-materials hub: <https://psoerensen.github.io/qgteach/>

## Repository Structure

```text
quantitative-genetics/
  _quarto.yml
  index.qmd
  slides/
  notes/
  tutorials/
  exercises/
  apps/
  data/
  images/
  narration/
  scripts/
  tools/
  docs/
```

The active Quarto source files are:

```text
index.qmd
slides/introduction_quantitative_genetics.qmd
slides/introduction_quantitative_genetics_narrated.qmd
```

## Requirements

Rendering requires:

- Quarto
- R

R packages used by the slides:

- `ggplot2`
- `MASS`
- `patchwork`
- `dplyr`

The narration tool additionally uses:

- `stringr`
- `fs`
- `jsonlite`

Generating narration requires `OPENAI_API_KEY`, `curl`, and network access. Obtain explicit approval before regenerating audio.

## Rendering

Render focused slide files:

```bash
quarto render slides/introduction_quantitative_genetics.qmd
quarto render slides/introduction_quantitative_genetics_narrated.qmd
```

Render the complete course website:

```bash
quarto render
```

Generated website files are written to `docs/`.
