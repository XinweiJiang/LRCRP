
function W = creatgraphW(Datatrain,options)
%
W=[]; 
Affinity = [];
[demnsion,samples]=size(Datatrain);

        for i = 1: samples
%             fprintf('lrcrp2 use:noI calculate the reconstruct weight of %d,total %d datapoint\n',[i,samples]);
            if mod(i,round(samples/20))==0,        fprintf('*...');       end
            temp = Datatrain;   % Da ta: d x m
            datai = temp(:, i); % Y: d x 1
            temp(:, i) = [];
            norms1 = sum((temp - repmat(datai, [1 size(temp,2)])).^2); 
            sorted_norm1 = sort(norms1);
            % add local information into regularization of crp. We have two ways to choose the nn samples.
            norms1(norms1>sorted_norm1(options.norm1_1)) = max(norms1);   
            G1 = diag(options.lamuda.*norms1);
            A = (temp'*temp + G1)\(temp'*datai);
            B = zeros(samples, 1);
            B([1:i-1, i+1:samples]) = A;
            Affinity(:,i) = B;
        end

W = (Affinity + Affinity')/2;
W = Affinity;

%  add laplacian regularization into crp in outside
options1 = [];
options1.NeighborMode = 'KNN';
options1.k = options.k;
options1.WeightMode = 'HeatKernel';
options1.t = 1;
W0=constructW_2(Datatrain',options1.k,options1.t);
Lap = full(diag(sum(W0))-W0);
% beta can be used to balance the two regularization items in the following two ways
W = (1-options.beta).*W + options.beta.*Lap;   
        
