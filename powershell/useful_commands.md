

#### Count the number of lines in a (txt) file

`(gc [the_file.txt]).Count`


#### list the content of a directory and grep for a substring

`ls some_dir |  ? { $_.Name -like "*some_string*" }

#### disply tree like structure for a python project
`eza --group-directories-first -a --tree -I ".venv|*.egg-info|data|logs|outputs|.git|.ruff_cache|*pyc|*pycache*|results*|.pytest*|.mypy*"`
