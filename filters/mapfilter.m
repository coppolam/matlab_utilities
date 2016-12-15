function [ mu_map] = mapfilter(n, mu, mu_prior, var, var_prior)
%mapfilter Applies a filter in the style of the maximum a-posteriori
%estimate for a univariate Gaussian distribution
%
% Mario Coppola, February 2016

if var < 0 
    error('Please specify a positive variance. A negative one doesnt make sense')
end

if n < 0
    error('Cannot be at a negative time-step')
end

if any([size(mu), size(mu_prior), size(n), size(var)]) > 1
    error('Transition filter does not allow vectors as inputs')
end

div1 = n*var_prior + var;
div2 = 1 + var/(n*var_prior);

t1 = var * mu_prior;
t2 = mu;

mu_map = t1/div1 + t2/div2;

end