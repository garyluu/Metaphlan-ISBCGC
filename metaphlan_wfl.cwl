cwlVersion: v1.0
class: Workflow

doc: |
  # Metaphlan-ISBCGC

  # Overview
  This is an example of how to add a description to a workflow. This uses markdown and can show things like images and links. 

dct:creator:
    foaf:name: "Hsinyi Tsang"
    foaf:mbox: "hsinyi.confidential@nih.gov"

inputs:

  TARBZFILE:
    type: File
  UNZIPPEDFILENAME:
    type: string
    default: temp.tarbz.out
  stdoutflag:
    type: string
  
  bowtie2db:
    type: string
  bowtie2exe:
    type: string
  bt2:
    type: string
  inputtype:
    type: string
  bowtie2out:
    type: string
  OUTFILENAME:
    type: string

  profOut:
    type: string
  TREENAME:
    type: string
  ANNOTNAME:
    type: string

  ANNOTOUTNAME:
    type: string

  dpi:
    type: int
  PNGFILE:
    type: string

############

outputs:
  graphlanoutput:
    type:
      File
    outputSource: graphlan/graphlanOut

############

steps:

  untar:
    run: tool1.tarbz.cwl
    in:
      fastq: TARBZFILE
      unzippedFileName: UNZIPPEDFILENAME
      stdoutflag: stdoutflag
    out: [unzippedFile]

  profile:
    run: tool2.profile.cwl
    in:
      fileToSearch: untar/unzippedFile
      bowtie2db: bowtie2db
      bowtie2exe: bowtie2exe
      bt2: bt2
      inputtype: inputtype
      bowtie2out: bowtie2out
      outFileName: OUTFILENAME
    out: [profileOut]

  meta2graph:
    run: tool3.meta2graph.cwl
    in: 
      profOut: profile/profileOut
      treefile: TREENAME
      annotfile: ANNOTNAME
    out: [TreeOut, AnnotOut]

  annotate:
    run: tool4.annotate.cwl
    in:
      annotfile2: meta2graph/AnnotOut
      treefile2: meta2graph/TreeOut
      annotOutName: ANNOTOUTNAME
    out: [annotateOut]

  graphlan:
    run: tool5.graphlan.cwl
    in:
      dpi: dpi
      xmlfile: annotate/annotateOut
      pngfile: PNGFILE
    out: [graphlanOut]
