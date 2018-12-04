function [out, names] = Extract_long(dirname,subname,counter)
    full = strcat(dirname,'/',subname);
    files = dir(full);
    out = zeros(2783582,length(files)-2);
    for file = files'
        if file.name == '.'
            continue
        end
        name = strcat(full,'/',file.name);
        [x,~] = audioread(name);
        x = x(:,1);
        if length(x) ~= length(out)
            if length(x) > length(out)
                out(numel(x),:) = 0;
            else
                x(numel(out(:,1))) = 0;
            end
        end
        out(:,counter) = x;
        counter = counter+1;
    end
    names =[];
    counter = 1;
    start = length(full)+2;
    for file = files'
        if file.name == '.'
            continue
        end
        name = strcat(full,'/',file.name);
        if subname(1:4) == 'Free'
            temp = string(name(start:end));
            pername = extractBefore(temp,'-');
        else
            pername = string(name(start:end-6));
        end
        names{counter} = pername;
%       names(:,counter) = pername;
        counter = counter+1;
    end
end