(lang dune 3.7)

(name ocaml_rest)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Anek Green")

(maintainers "Movepoint Solutions")

(license LICENSE)

(documentation https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html)

(package
 (name ocaml_rest)
 (synopsis "OCaml reStructuredText parser")
 (description "Angstrom-based ReST parser")
 (depends ocaml dune)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
