function weights = FindOptimalPortfolio(dS1,dS2)
% This is a simple Portfolio Optimization algorithm for Cointelated Pairs.
% I first optimize for the Long Long case and then the Short Long case and
% I return the weights of the portfolio with the highest Sharpe Ratio.


% First the long long case
% I iterate over all possible portfolios such that w1,w2>0 and w1 + w2 = 1.
% I record the combination that had the highest sharp
w1Temp = 0;
w2Temp = 1 - w1Temp;
bestPortfolioSR = 0;
bestWeights=[w1Temp, w2Temp];

iterator = 1;

for i=0:.005:1
    w1Temp = i;
    w2Temp = 1 - w1Temp;
    tempPorfolioRet(1:size(dS1)) = 0;
    for j=1:size(dS1)
        tempPorfolioRet(j) = w1Temp * dS1(j) + w2Temp * dS2(j);
    end
    iterator = iterator + 1;
    SR(iterator) = mean(tempPorfolioRet)/std(tempPorfolioRet);
    
    if bestPortfolioSR < SR(iterator)
        bestPortfolioSR = SR(iterator);
        bestWeights = [w1Temp, w2Temp];
    end
end

% Second the long short case
% I iterate over all possible portfolios such that sign(w1) = -sign(w2) and
% |w1| + |w2| = 1. I record the combination that had the highest sharp
iterator = 1;
for i=-1:.005:1
    w1Temp = i;
    % w2Temp = -sign(w1Temp)*(1-abs(i));    
    w2Temp = -w1Temp;
    tempPorfolioRet(1:size(dS1)) = 0;
    for j=1:size(dS1)
        tempPorfolioRet(j) = w1Temp * dS1(j) + w2Temp * dS2(j);
        %returnsCheck = [dS1,dS2]
        
    end
    iterator = iterator + 1;
    SR(iterator) = mean(tempPorfolioRet)/std(tempPorfolioRet);
    
    if bestPortfolioSR < SR(iterator)
        bestPortfolioSR = SR(iterator);
        bestWeights = [w1Temp, w2Temp];
    end
    
end



weights = bestWeights;
end