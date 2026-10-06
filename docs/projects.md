# Open-Source Project Guide

Project information was checked on October 5, 2026. Instructions and issues can change: reread the linked contributor guide when beginning work.

## 1. SQLFluff: Start Here

[Repository](https://github.com/sqlfluff/sqlfluff) | [Contributor guide](https://github.com/sqlfluff/sqlfluff/blob/main/CONTRIBUTING.md) | [Introduction](https://docs.sqlfluff.com/en/stable/guide/) | [SQL dialects](https://docs.sqlfluff.com/en/stable/reference/dialects/)

SQLFluff is an open-source SQL linter with dialect support including BigQuery, Redshift, and Snowflake. Its contributor guide recommends using the tool first and welcomes useful documentation improvements and reproducible SQL examples.

Start with the supplied synthetic SQL, then explain one rule and one fixture. This uses your SQL knowledge before requiring a Python code change.

Useful repository areas:

- `pyproject.toml`: supported Python versions, package information, and dependencies.
- `src/sqlfluff/`: implementation, including dialect and rule code.
- `test/fixtures/rules/std_rule_cases/`: rule examples.
- `test/fixtures/dialects/`: SQL dialect examples and fixture guidance.
- `docsv/` and `.github/workflows/`: documentation and automated checks.

Search [current beginner-labelled issues](https://github.com/sqlfluff/sqlfluff/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) when you reach Week 11. No particular issue is reserved or promised. Prefer a documentation clarification, a minimal SQL reproduction, or an explained fixture over a parser feature at the beginning.

The project requires passing checks and makes contributors responsible for AI-assisted changes. Disclose material AI assistance according to its guide.

## 2. SQLGlot: A Bridge from SQL to Python

[Repository](https://github.com/tobymao/sqlglot) | [Contributor guide](https://github.com/tobymao/sqlglot/blob/main/CONTRIBUTING.md) | [Onboarding](https://github.com/tobymao/sqlglot/blob/main/posts/onboarding.md) | [Expression-tree primer](https://github.com/tobymao/sqlglot/blob/main/posts/ast_primer.md)

SQLGlot is an open-source Python SQL parser and transpiler. Begin by using its library on small synthetic queries, specifying source and target dialects explicitly.

Useful repository areas:

- `sqlglot/`: library implementation and dialect definitions.
- `tests/dialects/test_bigquery.py`: BigQuery-focused cases.
- `posts/`: explanations of architecture and contributor onboarding.

A translated query is a candidate, not a verified warehouse migration. Parsing does not prove that a database accepts the query or returns equivalent results. Study date/time, null, and type behavior separately.

The contributor guide asks new contributors to prefer a clear issue with a reproduction over an early PR. It also requires understanding submitted code and encourages disclosure of LLM use. Do not choose a large parser change for your first lesson.

## 3. BigQuery Terraform Module: Read Infrastructure Code

[Repository and examples](https://github.com/terraform-google-modules/terraform-google-bigquery) | [Contributor guide](https://github.com/terraform-google-modules/terraform-google-bigquery/blob/main/CONTRIBUTING.md)

This open-source module defines BigQuery datasets, tables, and related objects through Terraform inputs. Study its README, input declarations, resources, outputs, and examples as one connected system.

Use the local configuration in `samples/terraform/` to practice formatting and validation. It intentionally declares no provider, backend, module download, or cloud resource. It demonstrates values and schema encoding, rather than provisioning a dataset.

The upstream contributor guide describes generated README tables and cloud-backed integration tests. Read those requirements before planning an upstream change. The integration suite can create infrastructure; it is not part of this local workshop.

## Supplementary: Liquibase

[Repository](https://github.com/liquibase/liquibase) | [Contributor guidance](https://contribute.liquibase.com/) | [License explanation](https://www.liquibase.com/blog/liquibase-community-for-the-future-fsl)

Liquibase is directly relevant to database changesets and CI/CD. Current Community releases from 5.0 use FSL and are **source-available**, not currently open source. Earlier Apache-licensed versions retain their license. Treat it as supplementary work-tool study, with a disposable local database.

Start with `samples/liquibase/changelog.sql`: a table changeset followed by a dependent view changeset. Read the optional local lab in the curriculum before running it.

## A Repeatable Repository-Reading Method

1. State the user-visible behavior you want to understand.
2. Run one small example and record the version and result.
3. Read the README, contributor guide, license, and package or build metadata.
4. Map only the folders needed for that behavior.
5. Trace one input into the relevant code or configuration and then to its output.
6. Read one nearby test and run the narrowest useful check.
7. Change one thing in a disposable exercise and explain the changed result.
8. Prepare a contribution only when you can explain the expected behavior and verification.

## Before Choosing an Issue

- Recheck its state, recent discussion, assigned contributors, and linked PRs.
- Confirm that its dialect and problem match something you understand.
- Reproduce it with current code and synthetic input; old examples may no longer fail.
- Keep the scope small enough to explain and verify within a few sessions.
- Ask maintainers a focused question when scope is unclear. Prepare the message locally first; send only when you explicitly choose to.
- Respect each project's tests, licensing expectations, and AI-contribution policy.

Your first useful contribution can be an accurate reproduction or a tested documentation improvement. A merged upstream code change is a later outcome, not a prerequisite for learning.
