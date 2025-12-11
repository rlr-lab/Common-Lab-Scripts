# Common-Lab-Scripts

Use this repo to share code used in multiple projects. Use the README here to give a brief description of each upload. For folders of files, more descriptive instructions can be left in a `README.md` within that folder.

## Descriptions

- **LaTeX_Poster/:** A poster template written in LaTeX for any math-heavy posters where you don't want to use Powerpoint. Created/tested in Overleaf.
  - For a LaTeX slideshow template, see [wildcat](https://github.com/seth-borrowman/wildcat)
- **Reference_Genomes/:** Commonly used reference genomes, and some associated BED/primer/SnapGene files.
- **SIVmac239_Barcode/:** Files used for counting unique barcodes in SIVmac239 samples.
- **ivar_consensus_alignment.sh:** Create consensus sequences and aligned BAMs for a collection of FASTQ files. Uses `ivar` to generate consensus sequences. Works by aligning to reference, creating consensus, realigning to the consensus, and generating a new consensus.

