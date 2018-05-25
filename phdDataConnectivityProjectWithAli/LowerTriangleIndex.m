function [ index ] = LowerTriangleIndex( N )
%LOWERTRIANGLEINDEX Summary of this function goes here
%   Detailed explanation goes here
%   N = dimension of matrix
%   index = lower triangle index
    temp = 1:N^2;
    temp = reshape(temp,N,N);
    flag = tril(ones(N,N),-1);
    index = find((temp.*flag)~=0);
end
