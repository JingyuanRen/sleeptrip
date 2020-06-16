function cfg = st_savefigure(cfg, fh)
timerVal = tic;
memtic
st = dbstack;
functionname = st.name;
fprintf([functionname ' function started\n']);

timestampfix = '';
    if istrue(cfg.timestamp)
        timestampfix = ['_' datestr(dt,'yyyy-mm-dd-HH-MM-SS-FFF')];
    end
    
    subfolderpath = '';
    if istrue(cfg.folderstructure)
        subfolderpath = ['res' filesep];
        if ~isdir([subfolderpath functionname])
            mkdir([subfolderpath functionname]);
        end
        if ~isdir([subfolderpath functionname filesep 'hypnograms'])
            mkdir([subfolderpath functionname filesep 'hypnograms']);
        end
        subfolderpath = [subfolderpath functionname filesep 'hypnograms'];
        [path filename ext] = fileparts(cfg.figureoutputfile);
        cfg.figureoutputfile = [subfolderpath filesep filename timestampfix ext];
    else
        [path filename ext] = fileparts(cfg.figureoutputfile);
        cfg.figureoutputfile = [path filesep filename timestampfix ext];
    end
            
    switch cfg.figureoutputformat
        case 'fig'
            [path filename ext] = fileparts(cfg.figureoutputfile);
            if ~strcomp(ext,['.' cfg.figureoutputformat])
                cfg.figureoutputfile = [cfg.figureoutputfile  '.fig'];
            end
            saveas(fh, [cfg.figureoutputfile  '.fig']);
        case 'eps'
            print(fh,['-d' 'epsc'],['-r' num2str(cfg.figureoutputresolution)],[cfg.figureoutputfile]);
        otherwise
            print(fh,['-d' cfg.figureoutputformat],['-r' num2str(cfg.figureoutputresolution)],[cfg.figureoutputfile]);
    end

fprintf([functionname ' function finished\n']);
toc(timerVal)
memtoc
end