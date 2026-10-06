# Data Engineering Learning Workshop

A practical learning notebook for a SQL-focused database architect learning Python and open-source development.

**Pace:** 1-2 hours per week, usually two sessions of 30-60 minutes. The week numbers are milestones, not deadlines: repeat a lesson when needed.

## Start Here

1. Follow the [Windows setup guide](docs/setup.md).
2. Open [Week 1: Compare Row Counts](docs/curriculum.md#week-1-compare-row-counts).
3. Run the first exercise from the repository root:

   ```powershell
   .\.venv\Scripts\python.exe exercises/week01/row_counts.py
   ```

4. Predict the result, make the suggested change yourself, and explain what changed.
5. Record your attempt in [PROGRESS.md](PROGRESS.md).

## What I Already Know

SQL is my strongest language. I understand commits, branches, pull requests, and the GitHub workflow. My work involves BigQuery, Terraform, Liquibase, and CI/CD.

Python, unfamiliar codebases, debugging, and test-writing are my next learning priorities.

## Twelve-Week Path

| Week | Focus | Evidence of Learning |
| --- | --- | --- |
| 1 | Python setup, variables, arithmetic, output | Explain and modify the row-count example. |
| 2 | Lists, dictionaries, loops, conditions | Summarize a small table manifest. |
| 3 | Functions, errors, and unit tests | Write and test a row-count comparison function. |
| 4 | CSV, JSON, and file paths | Summarize synthetic orders and handle bad input. |
| 5 | Using SQLFluff | Explain SQL lint results and fix a sample. |
| 6 | Reading SQLFluff's repository | Trace one rule or fixture to a relevant test. |
| 7 | Using SQLGlot from Python | Translate a synthetic query between dialects. |
| 8 | SQLGlot tests and limitations | Record a translation edge case and inspect a test. |
| 9 | BigQuery Terraform module inputs | Trace dataset and table configuration. |
| 10 | Local Terraform checks; Liquibase study | Explain a validation result and database changeset. |
| 11 | Reproducing a project problem | Prepare a minimal, synthetic reproduction. |
| 12 | Preparing a useful contribution | Explain the change, checks, and remaining limitations. |

Every lesson in the [curriculum](docs/curriculum.md) includes prerequisites, steps, expected results, troubleshooting, and an explanation checkpoint.

## Projects

| Project | Why It Fits | Starting Point |
| --- | --- | --- |
| [SQLFluff](https://github.com/sqlfluff/sqlfluff) | Connects familiar SQL to Python tooling and automated checks. | Use its CLI on synthetic BigQuery SQL before reading parser code. |
| [SQLGlot](https://github.com/tobymao/sqlglot) | Makes Python useful for investigating SQL dialect differences. | Translate one small query, inspect the result, then read a test. |
| [BigQuery Terraform Module](https://github.com/terraform-google-modules/terraform-google-bigquery) | Connects module inputs and examples to database infrastructure. | Read the README and trace a dataset example without deploying it. |

The [project guide](docs/projects.md) includes contributor guides, repository maps, and contribution-readiness checks.

[Liquibase](https://github.com/liquibase/liquibase) is supplementary study. Community 5.0 and later use a **source-available** license, rather than an open-source license. See [Liquibase's explanation](https://www.liquibase.com/blog/liquibase-community-for-the-future-fsl).

## Progress

- [ ] Set up Python and an isolated environment.
- [ ] Explain and modify the Week 1 example.
- [ ] Use lists, dictionaries, loops, and conditions.
- [ ] Write a function and meaningful tests.
- [ ] Read CSV and JSON files and handle errors.
- [ ] Use SQLFluff and understand a relevant test.
- [ ] Use SQLGlot and explain translation limitations.
- [ ] Trace BigQuery Terraform inputs and run local validation.
- [ ] Understand a Liquibase changeset and its rollback example.
- [ ] Reproduce a real project problem with synthetic data.
- [ ] Prepare a focused contribution I can explain.

The workshop author running an example does not complete my learning milestones. I check these off after demonstrating understanding.

## How This Repository Works

- `docs/`: setup, curriculum, and project-reading guidance.
- `exercises/week01/`: the runnable starting example.
- `data/`: small, synthetic CSV and JSON datasets.
- `samples/`: SQL, local Terraform configuration, and a Liquibase changelog.
- `.github/workflows/`: a starter automated check that runs the first example.
- `PROGRESS.md`: attempts, explanations, questions, and the next exercise.

Later Python exercises are written during their lessons. Tests added in Week 3 will extend the starter CI workflow.

All data and identifiers here are synthetic. Cloud deployment and employer systems are outside this workshop. SQL translation and local configuration validation do not establish production correctness.
