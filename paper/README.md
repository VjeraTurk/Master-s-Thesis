
### Official Template changes
Official Faculty template is available at http://nastavno.mjoler.info/dipl and [here](https://drive.google.com/drive/folders/0B8kqcALDDvC_VC0ydU1iM0k3RTA)

1. Only LaTex base was installed (as full version is over 5GB), leading later to few packages missing. **Jabref** was also installed, for managing references.

        sudo apt-get install texlive-latex-base jabref

2. Encoding not set correctly for **Linux**. In TexStudio, under encoding  ...

    2.1. **"Reload With"** each file with **windows-1250** encoding  
    2.2. **"Change To"** ecach file encoding to windows-1250  
    2.3. **"insert Encoding as Tex comment"** in each file  
    2.4 IGNORE (do not uncomment Linux settings) in rithesis_preamble.tex:  
    
    **OR:** (not tested)  
    2.1. Follow 2.1 as above  
    2.2. Follow 2.2 with **UTF-8** instead of windows-1250  
    2.3. Follow 2.3. with **UTF-8** instead of windows-1250  
    2.4  Uncomment Linux settings in rithesis_preamble.tex (comment line for Windows):  

        %%%%%%% adjustment for croatian
        \usepackage[croatian]{babel}
        \usepackage[cp1250]{inputenc}	% this ensures croatian special letters are correctly printed with Windows
        %\usepackage[utf8]{inputenc}		% allegedly this will produc Croatian special letter correctly in Linux  



3.  File `enumitem.sty' not found. \setlist (in ritehsis_preamble.tex)

        sudo apt-get install texlive-latex-extra
        sudo texhash

    WARNING: It seems
    
        sudo texthash
    is important after LaTeX package installation, otherwise TeXstudio might not open- problematic file seems to be glossaries.sty 

4. Package babel Error: Unknown option `croatian'. Either you misspelled itnd. \ProcessOptions*  
    [solution](https://tex.stackexchange.com/questions/139700/package-babel-error-unknown-option-francais):
        
        sudo apt-get install texlive-lang-european
        sudo texhash


4. File `tracklang.sty' not found. \@gls@usetranslator  
    [solution](https://tex.stackexchange.com/questions/254052/new-error-using-glossaries-package-tracklang-sty):

        sudo apt-get install texlive-generic-extra
        sudo texhash

5. All Titles from .bib file have forced *lowercase* on all words accept first word in Title. Unable to use Capital letters (are ignored) for example: Boston -> boston

Apparently this is a ["Feature"](https://tex.stackexchange.com/questions/86820/incorrect-case-in-bibtex  
), and can in some cases be [overwritten in .bst file](https://tex.stackexchange.com/a/10775/113519).  
Other solution is to use [{ }](https://tex.stackexchange.com/questions/10772/bibtex-loses-capitals-when-creating-bbl-file  
) around parts of title (or entire title) we wish to keep capitalised  


