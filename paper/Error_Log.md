1. Encoding not set, in TexStudio, under encoding  
    1.1. **Reload With** each file with **windows-1250**  
    1.2. **Change To** windows-1250  
    1.3. "insert Encoding as Tex comment"  

    1.4 IGNORE (do not change uncomment Linux settings):  
        %%%%%%% adjustment for croatian  
        \usepackage[croatian]{babel}  
        \usepackage[cp1250]{inputenc}	% this ensures croatian special letters are correctly printed with Windows  
        %\usepackage[utf8]{inputenc}		% allegedly this will produc Croatian special letter correctly in Linux  

    OR (not tested)  

    Uncomment Linux settings
    CHANGE (encoding) TO UTF-8 and "insert Encoding as Tex comment for each file


2. File `enumitem.sty' not found. \setlist (in ritehsis_preamble.tex)

        sudo apt-get install texlive-latex-extra
        sudo texhash

    (It seems sudo **texthash** is important, otherwise TeXstudio won't open- problematic file seems to be glossaries.sty)

3. Package babel Error: Unknown option `croatian'. Either you misspelled itnd. \ProcessOptions*
    [solution:](https://tex.stackexchange.com/questions/139700/package-babel-error-unknown-option-francais)
        
        sudo apt-get install texlive-lang-european
        sudo texhash


4. File `tracklang.sty' not found. \@gls@usetranslator
    [solution:](https://tex.stackexchange.com/questions/254052/new-error-using-glossaries-package-tracklang-sty)

        sudo apt-get install texlive-generic-extra
        sudo texhash

