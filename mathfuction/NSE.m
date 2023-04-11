function ret = NSE (pre, obs)
%% [0] File info.
% Program: NSE.m
% File Type: Function file
% Last modification date : 20161109
% 
% Input : pre, obs
% prediction values and observed values
% Output : ret
% return value of NSE
%
% Please contact to me, if you have any question about this code.
% e-mail : fblsj90@gmail.com
% 
% @author: ???
%
%% [1] Code
upper = sum((pre - obs).^2);
down = sum((obs - mean(obs) .* ones(size(obs, 1), 1)) .^ 2);
ret = 1 - upper / down;
end
