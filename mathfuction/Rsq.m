function R2 = Rsq(oriPre, oriObs)
N = length(oriObs);
avgObs = mean(oriObs) * ones(N, 1);

SSE = sum((oriObs - oriPre).^2);
SSR = sum((oriPre - avgObs).^2);

SST = SSE + SSR;

R2 = SSR/SST;
end
