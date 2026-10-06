# Twelve-Week Curriculum

Use two sessions of 30-60 minutes each week. In the first, understand and try the example. In the second, change it, debug it, and explain the result. Repeat a week when its checkpoint is unclear.

The Python commands below assume PowerShell in the repository root and the environment described in [setup](setup.md). All exercises use synthetic data. Add later exercise files during their lessons, rather than collecting finished solutions in advance.

## Week 1: Compare Row Counts

**Purpose:** Understand how Python runs instructions, stores values, and calculates a result.

**Prerequisites:** Complete the setup guide. No Python knowledge is assumed.

**Steps:**

1. Read `exercises/week01/row_counts.py` before running it. Predict all three output lines.
2. Run the example using `.\.venv\Scripts\python.exe exercises/week01/row_counts.py`.
3. Identify the variables, arithmetic expression, and `print` calls. An f-string inserts values into text.
4. Change `target_rows` to `120`, predict the difference, then run again.
5. Change it to `121`. Explain the negative result and why the label `Missing rows` is too simple for this case. Restore the original example after experimenting, or record your intentional change.

**Expected result:** The original values produce source `120`, target `118`, and difference `2`. Equal counts produce `0`; target `121` produces `-1`, meaning the target has one extra row by count.

**Troubleshooting:** A `NameError` often means a misspelled variable. A `SyntaxError` means Python could not read the instructions: inspect the named line and the preceding line. Run from the repository root if the file cannot be found.

**Checkpoint:** Explain `=` versus `==`, what happens when the values change, and why matching row counts do not prove matching data. Record your prediction, attempt, and explanation in `PROGRESS.md`.

## Week 2: Lists, Dictionaries, Loops, and Conditions

**Purpose:** Represent a small table manifest and apply the same operation to several entries.

**Prerequisites:** Week 1 checkpoint; variables and arithmetic.

**Steps:**

1. Open `data/table_manifest.json`. Treat each object as a record and the surrounding array as a collection; Python dictionaries and lists are related but distinct runtime objects.
2. Create `exercises/week02/manifest_summary.py`. For now, type those three records into a Python list of dictionaries. File-reading comes in Week 4.
3. Loop over the list. Print each table name and the source-minus-target difference.
4. Add a condition that reports `match`, `target short`, or `target extra`.
5. Add a fourth synthetic table and check that the loop handles it without an extra print statement.

**Expected result:** `orders` differs by `2`, `customers` by `0`, and `products` by `-1`, with the corresponding three status labels.

**Troubleshooting:** A `KeyError` means the requested dictionary key is absent. Indentation defines the body of a loop or condition. Keep JSON's double-quoted keys separate from Python's syntax rules.

**Checkpoint:** Compare this loop with a SQL query that calculates a derived column for every row. Explain why neither a list nor a dictionary is a database table.

## Week 3: Functions, Errors, and Tests

**Purpose:** Separate a calculation from its display and verify behavior with examples.

**Prerequisites:** Week 2; lists, conditions, and signed differences.

**Steps:**

1. Create `exercises/week03/row_counts.py` with a `row_difference(source_rows, target_rows)` function that returns the signed difference.
2. Call it with the three cases from Week 2. Keep printing outside the function.
3. Decide that negative input counts are invalid and raise `ValueError` for them. A negative difference remains valid.
4. Create `test_row_counts.py` beside it using the standard-library `unittest` module. Test equal counts, a short target, an extra target, zero counts, and a negative input.
5. Run `.\.venv\Scripts\python.exe -m unittest discover -s exercises/week03 -p "test_*.py"`.
6. Temporarily reverse the subtraction. Observe which tests fail, then restore the correct calculation.
7. Add the unittest command to `.github/workflows/python-check.yml`. Extend its path filters if tests later move elsewhere.

**Expected result:** Your correct function passes the cases you wrote. The reversed calculation fails the directional cases. The first CI workflow already runs the Week 1 script; running a script is different from asserting behavior in tests.

**Troubleshooting:** A file must match the discovery pattern. An import can fail if its module name and location do not match your test setup. Read the assertion's expected and actual values before editing code.

**Checkpoint:** Explain `return` versus `print`, an exception versus a test failure, and why testing only equal counts misses a reversed-subtraction bug.

## Week 4: CSV, JSON, and File Paths

**Purpose:** Read records from files and produce a small, reliable summary.

**Prerequisites:** Week 3 functions and errors.

**Steps:**

1. Create `exercises/week04/order_summary.py`. Use the standard-library `csv.DictReader` to read `data/orders.csv`.
2. Explain why CSV values arrive as strings. Convert `amount` using `decimal.Decimal` before summing money.
3. Report the row count, total amount, and totals by market. This parallels `COUNT`, `SUM`, and `GROUP BY` in SQL.
4. Load `data/table_manifest.json` with the standard-library `json` module and reuse your comparison logic.
5. Use `pathlib.Path` to make file paths understandable. Initially run from the repository root; then deliberately try another folder and explain the difference.
6. Test a missing file and a copied CSV with one invalid amount. Produce an error that identifies the problem without silently dropping the record.

**Expected result:** Four orders total `50.00`; market `alpha` totals `25.50` and `beta` totals `24.50`. The JSON manifest gives the same differences as Week 2.

**Troubleshooting:** `FileNotFoundError` points to path or working-directory problems. Use a parser rather than splitting CSV lines yourself. Handle only errors you understand; do not hide all failures with a broad exception handler.

**Checkpoint:** Explain the relationship between input types, conversion, aggregation, and output. Describe why a file export is not a live database connection.

## Week 5: Use SQLFluff Before Reading Its Internals

**Purpose:** Understand a Python command-line tool through a SQL example you can inspect.

**Prerequisites:** Weeks 1-4; internet access for package installation.

**Steps:**

1. Read the [SQLFluff introduction](https://docs.sqlfluff.com/en/stable/guide/).
2. Install it into the learning environment: `.\.venv\Scripts\python.exe -m pip install sqlfluff`.
3. Record `.\.venv\Scripts\sqlfluff.exe --version` in your progress entry.
4. Run `.\.venv\Scripts\sqlfluff.exe lint --ignore-local-config --dialect bigquery --rules LT01,LT02,LT09 samples/sql/orders_bigquery.sql`. Ignoring other config files keeps this first exercise independent of settings elsewhere on your machine.
5. Explain one violation using its line, position, rule, and suggested change. Edit a copy of the sample yourself.
6. Compare with `orders_bigquery_clean.sql`, then lint that reference with the same command and selected rules.

**Expected result:** The uneven sample reports layout violations. The reference has no violations for the selected rules. Rule selection narrows this exercise; other configurations can report additional findings.

**Troubleshooting:** Use the executable inside `.venv` if `sqlfluff` is not on your path. Always specify the dialect. A lint command can return a nonzero exit code because it found violations; that is useful CI behavior. Later, remove `--ignore-local-config` when deliberately exploring your own project configuration.

**Checkpoint:** Explain linting versus database execution, why dialect matters, and what a nonzero exit code tells a pipeline.

## Week 6: Read SQLFluff's Repository and a Test

**Purpose:** Navigate one behavior through documentation, source, fixtures, and checks.

**Prerequisites:** Week 5; the [SQLFluff contributor guide](https://github.com/sqlfluff/sqlfluff/blob/main/CONTRIBUTING.md).

**Steps:**

1. Make a separate local checkout of SQLFluff, outside this learning repository. Record the commit you inspect.
2. Locate its package metadata, `src/`, `test/`, documentation, and `.github/workflows/`.
3. Choose one rule from Week 5. Search for its identifier in source and the fixtures under `test/fixtures/rules/std_rule_cases/`.
4. Read one passing and one failing example; write down what changes between them.
5. Follow the current contributor guide to create a separate development environment for SQLFluff. Do not reuse the learning environment for every upstream project.
6. Run only the relevant test selection first. Record the command, environment, and result. If setup exceeds the session, record the blocker and continue next time.

**Expected result:** A short map connecting a rule, its implementation, a fixture, and a test runner; ideally one focused test run. No parser change is required.

**Troubleshooting:** An installed package and a source checkout can be different versions. Verify which code the interpreter imports. Upstream development dependencies differ from normal package dependencies.

**Checkpoint:** Explain what the test establishes and what it leaves untested. Describe how you would check that a small change does not break nearby behavior.

## Week 7: Explore SQL Dialects with SQLGlot

**Purpose:** Make a Python library useful for a familiar SQL task.

**Prerequisites:** Python functions and file-reading; the [SQLGlot README](https://github.com/tobymao/sqlglot).

**Steps:**

1. Install the pure Python package with `.\.venv\Scripts\python.exe -m pip install sqlglot` and record the installed version.
2. Create `exercises/week07/translate_query.py`. Read `samples/sql/orders_redshift.sql`.
3. Use SQLGlot's `transpile` function with explicit `read="redshift"` and `write="bigquery"` arguments.
4. Print the generated query and compare its date arithmetic with the input. Inspect the output list before selecting an item.
5. Try a synthetic Snowflake query using explicit source and target dialects. Change only one expression at a time.

**Expected result:** The Redshift `DATEADD` expression becomes BigQuery-style date addition. Formatting can vary with the installed version. The output is a candidate query to inspect, not proof of equivalent results.

**Troubleshooting:** Missing source dialect can change parsing assumptions. Missing target dialect changes generation. Check the exception and library documentation rather than editing generated SQL until it happens to look plausible.

**Checkpoint:** Explain why parsing, SQL generation, and execution validation are separate tasks. List one semantic question to check, such as date versus timestamp behavior or null handling.

## Week 8: Read SQLGlot Tests and Record an Edge Case

**Purpose:** Learn how a project records supported SQL behavior and how to describe limitations.

**Prerequisites:** Week 7; the [contributor guide](https://github.com/tobymao/sqlglot/blob/main/CONTRIBUTING.md) and [onboarding guide](https://github.com/tobymao/sqlglot/blob/main/posts/onboarding.md).

**Steps:**

1. Make a separate checkout and record its commit. Follow its current development setup instructions.
2. Open `tests/dialects/test_bigquery.py`. Find a small test near the SQL feature you explored.
3. Read the test helper before interpreting its assertions. Identify the input dialect, target dialect, and expected output.
4. Run a focused test following the project's current instructions. Do not run a full suite before understanding one case.
5. Write a note about an unfamiliar or unsupported translation: input SQL, exact versions, actual output, desired behavior, and the source of that expectation.
6. Explain the code path at a high level before proposing any change.

**Expected result:** One explained test and one reproducible learning note. A misunderstanding that you resolve is also a useful result.

**Troubleshooting:** Extra test dependencies may be required. Successful parsing does not imply a database accepts the query. SQLGlot does not currently promise beginner issues; do not assume its core parser is a suitable first coding task.

**Checkpoint:** Explain the difference between a project bug, unsupported syntax, and an incorrect assumption. SQLGlot asks new contributors to prefer a well-written issue before a PR; follow that guidance.

## Week 9: Trace BigQuery Terraform Module Inputs

**Purpose:** Connect a module's public inputs to the infrastructure definitions behind them.

**Prerequisites:** Familiarity with Terraform workflows; the [module README](https://github.com/terraform-google-modules/terraform-google-bigquery).

**Steps:**

1. Read the module's dataset, table, view, and schema inputs.
2. Pick one example under its `examples/` directory and record the inspected commit.
3. Trace `dataset_id` from the example into the input declaration and dataset resource configuration.
4. Trace one table schema and explain what `file(...)` and JSON encoding do at the configuration boundary.
5. Read `samples/terraform/main.tf` here. Map its synthetic values to the upstream module's inputs.
6. Write a small diagram or prose trace: caller input, variable, transformation, resource argument, and output.

**Expected result:** An explanation of one dataset and one table configuration. The supplied local sample has no provider or resource blocks and creates nothing in Google Cloud.

**Troubleshooting:** Generated README tables describe inputs but may not explain their full behavior. Follow references to source. A declared default does not necessarily match your organization's chosen configuration.

**Checkpoint:** Explain the difference between creating a dataset definition and moving its data. Explain where SQL view definitions belong in your understanding of the tools, without documenting employer workflows.

## Week 10: Local Terraform Checks and Liquibase Changesets

**Purpose:** Understand what each local check proves and how changesets order database changes.

**Prerequisites:** Week 9; Terraform installed from [HashiCorp's official instructions](https://developer.hashicorp.com/terraform/install). Liquibase execution is optional this week.

**Steps:**

1. In this repository root, run `terraform -chdir=samples/terraform fmt -check`.
2. Initialize the supplied local configuration with `terraform -chdir=samples/terraform init -backend=false`.
3. Run `terraform -chdir=samples/terraform validate`. This sample has no cloud provider, resource, remote module, or backend.
4. Temporarily misspell a reference to `var.dataset_id`, observe the validation error, and restore it.
5. Read `samples/liquibase/changelog.sql`. Explain the two changesets, their order, the view's dependency, and the rollback statements.
6. Read the optional Liquibase lab below. Keep actual execution for a disposable local environment.

**Expected result:** The unmodified Terraform configuration validates; a bad reference fails. You can explain why the table must exist before the view and why rollback order matters.

**Troubleshooting:** `fmt -check` checks formatting without rewriting. `validate` needs initialization and checks configuration consistency, not cloud permissions or successful deployment. Upstream integration tests can provision cloud resources; they are outside this local exercise.

**Checkpoint:** Distinguish syntax checks, configuration validation, execution previews, and integration tests. Explain why an already-applied changeset should not be casually edited.

## Week 11: Reproduce a Small Project Problem

**Purpose:** Investigate before proposing a change.

**Prerequisites:** An explained project test or behavior from Weeks 6 or 8; the current contributor guide.

**Steps:**

1. Choose SQLFluff as the default first contribution target. Recheck its current issues and contributor policies.
2. Select a small documentation gap, SQL example, or reproducible behavior you understand. Check comments, assignments, and linked PRs before treating an issue as available.
3. Create the smallest synthetic example that shows the behavior. Record package version or commit, command, configuration, expected result, and actual result.
4. Reduce the example until irrelevant tables and expressions are removed.
5. Locate a related fixture or test and explain how your example differs.
6. Prepare an issue draft locally if the scope or intended behavior needs maintainer clarification. Do not post it automatically.

**Expected result:** A reproducible note another person can run and understand. If no suitable issue exists, prepare an example or documentation review in this learning repository.

**Troubleshooting:** A `good first issue` label is a discovery aid, not an estimate. An old issue can be outdated, already addressed, or blocked. Do not invent a bug to satisfy the exercise.

**Checkpoint:** Explain the problem without repeating the entire investigation. State what you know, what you checked, and what remains uncertain.

## Week 12: Prepare a Focused Contribution

**Purpose:** Make a small change that is understandable, useful, and supported by evidence.

**Prerequisites:** Week 11 reproduction and a clear understanding of project expectations.

**Steps:**

1. Choose one change: a tested documentation improvement, a relevant test case, or a small fix you can explain.
2. Read neighboring code or documentation and follow its conventions.
3. For a behavior change, add a test that fails before the change and passes afterward. Documentation-only changes need the relevant documentation checks rather than an artificial unit test.
4. Run focused checks, then the additional checks required by the project. Read CI failure logs from the failing step rather than treating every failure as your code's fault.
5. Write a short PR draft yourself: problem, change, verification, and any limitations. Describe material AI assistance as the project's policy requires.
6. Review every changed line. Submit upstream only after you understand it and explicitly decide to submit; this workshop does not automatically send issues, comments, or PRs to maintainers.

**Expected result:** A reviewable contribution or learning-repository improvement, with evidence. An upstream merge is not required for completing the lesson.

**Troubleshooting:** Narrow the scope when feedback reveals unrelated changes. Ask a focused question when the expected behavior is unclear. Maintainers' response times are outside your control.

**Checkpoint:** Explain why the change is correct, what the checks cover, and how you would respond to one reviewer question.

## Optional Liquibase Local Lab

**Purpose:** Observe changeset history, SQL preview, and dependency-aware rollback.

**Prerequisites:** [Liquibase's local H2 example](https://github.com/liquibase/liquibase#an-h2-in-memory-database-example-for-cli), a compatible local Liquibase installation, and its documented disposable H2 setup. Use the installed version's instructions for configuration and command names. Community 5.0+ is source-available; see the [license explanation](https://www.liquibase.com/blog/liquibase-community-for-the-future-fsl).

**Steps:**

1. Copy the synthetic changelog into the disposable example workspace. Configure it to use that local H2 instance, not a warehouse connection.
2. Run changelog validation, then an update SQL preview using your version's documented commands. Inspect the table and view statements.
3. Apply to the disposable local database and inspect changeset history. Run the update again and observe that recorded changesets are not repeated.
4. Preview rolling back the most recent changeset; confirm the view is dropped before attempting to drop its underlying table. Execute only in the disposable lab.
5. Record what the history table tracks and why a preview is not the same as executed database behavior.

**Expected result:** Two applied changesets after the initial update; a repeated update has no pending changes. Rolling back the latest change removes the view while leaving the table.

**Troubleshooting:** An in-memory H2 instance can disappear when stopped; use the official example's documented lifecycle. Driver, Java, and CLI compatibility are separate setup concerns. If they exceed the session, read and explain the changelog first.

**Checkpoint:** Explain changeset identity, recorded history, dependency order, and the limits of a local H2 example for BigQuery-specific behavior.
