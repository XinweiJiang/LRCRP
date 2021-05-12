
function G = constructW_2(X,k,sigma)
    if size(X, 2) > size(X, 1)
        error('Number of samples should be higher than number of dimensions.');
    end
    if ~exist('no_dims', 'var')
        no_dims = 2; 
    end
    if ~exist('k', 'var')
        k = 12;
    end
    if ~exist('sigma', 'var')
		sigma = 1;
    end
    if ~exist('eig_impl', 'var')
        eig_impl = 'Matlab';
    end
    
    % Construct neighborhood graph
    %disp('Constructing neighborhood graph...');%构造图
    if size(X, 1) < 4000
        G = L2_distance(X', X');%计算与其他点的距离
        % Compute neighbourhood graph exm  [1,1;2,2],return
        % [0,1.412;1.412,0];
        [tmp, ind] = sort(G); 
        for i=1:size(G, 1)
            G(i, ind((2 + k):end, i)) = 0; %选出k邻近，其余点都赋予0
        end
        G = sparse(double(G));
        G = max(G, G');             % Make sure distance matrix is symmetric
    else
        G = find_nn(X, k);
    end
    G = G .^ 2;
	G = G ./ max(max(G));
    
    % Compute weights (W = G)
   % disp('Computing weight matrices...');
    
    % Compute Gaussian kernel (heat kernel-based weights)
    G(G ~= 0) = exp(-G(G ~= 0) / (2 * sigma ^ 2));%热核函数