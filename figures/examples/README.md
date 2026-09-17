# figures/examples

The worked example diagrams used in the chapters: `neural_network`, `neuron`,
`rnn` and `multihead_attention`. All are adapted from
[NNTikZ](https://github.com/fraserlove/nntikz) (MIT, Copyright (c) 2024 Fraser
Love), with the attribution kept in each file header and repeated in the caption
that uses it.

Each file is a **bare fragment**: it starts at `\begin{tikzpicture}` and carries
no `figure` environment, caption or label. Those are supplied at the call site in
`text/`, so the same fragment can be reused elsewhere with a different caption.

These exist to demonstrate the conventions. Delete them as your own figures
replace them, and remember to remove the corresponding `\input` and `figure`
block from `text/`.
