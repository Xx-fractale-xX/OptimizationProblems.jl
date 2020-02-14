# Hock and Schittkowski problem number 119.
#
#   Source:
#   Problem 119 in
#   W. Hock and K. Schittkowski,
#   Test examples for nonlinear programming codes,
#   Lectures Notes in Economics and Mathematical Systems 187,
#   Springer Verlag, Heidelberg, 1981.
#   
#   classification PLR-AN-16-8
#
# A. Montoison, Montreal, 05/2018.

export hs119

"HS119 model"
function hs119(args...)

  nlp  = Model()
  @variable(nlp, 0 <= x[i=1:16] <= 5, start = 10)
  
  c = Array{Float64}(undef,8)
  c = [2.5, 1.1, -3.1, -3.5, 1.3, 2.1, 2.3, -1.5]

  a = Array{Float64}(undef,16,16)
  a[1,:]  = [1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1]
  a[2,:]  = [0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0]
  a[3,:]  = [0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0]
  a[4,:]  = [0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0]
  a[5,:]  = [0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1]
  a[6,:]  = [0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0]
  a[7,:]  = [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0]
  a[8,:]  = [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0]
  a[9,:]  = [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1]
  a[10,:] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0]
  a[11,:] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0]
  a[12,:] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0]
  a[13,:] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0]
  a[14,:] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
  a[15,:] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]
  a[16,:] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]


  b = Array{Float64}(undef,8,16)
  b[:,1]  = [0.22, -1.46,  1.29, -1.10,     0,     0, 1.12,     0]
  b[:,2]  = [0.20,     0, -0.89, -1.06,     0, -1.72,    0,  0.45]
  b[:,3]  = [0.19, -1.30,     0,  0.95,     0, -0.33,    0,  0.26]
  b[:,4]  = [0.25,  1.82,     0, -0.54, -1.43,     0, 0.31, -1.10]
  b[:,5]  = [0.15, -1.15, -1.16,     0,  1.51,  1.62,    0,  0.58]
  b[:,6]  = [0.11,     0, -0.96, -1.78,  0.59,  1.24,    0,     0]
  b[:,7]  = [0.12,  0.80,     0, -0.41, -0.33,  0.21, 1.12, -1.03]
  b[:,8]  = [0.13,     0, -0.49,     0, -0.43, -0.26,    0,  0.10]
  b[:,9]  = [1   ,     0,     0,     0,     0,     0,-0.36,     0]
  b[:,10] = [0   ,     1,     0,     0,     0,     0,    0,     0]
  b[:,11] = [0   ,     0,     1,     0,     0,     0,    0,     0]
  b[:,12] = [0   ,     0,     0,     1,     0,     0,    0,     0]
  b[:,13] = [0   ,     0,     0,     0,     1,     0,    0,     0]
  b[:,14] = [0   ,     0,     0,     0,     0,     1,    0,     0]
  b[:,15] = [0   ,     0,     0,     0,     0,     0,    1,     0]
  b[:,16] = [0   ,     0,     0,     0,     0,     0,    0,     1]

  for i=1:8
    @NLconstraint(nlp, sum(b[i,j]*x[j] - c[i] for j=1:16) == 0)
  end

  @NLobjective(
    nlp,
    Min,
    sum(sum(a[i,j]*(x[i]^2 + x[i] + 1)*(x[j]^2 + x[j] + 1) for j=1:16) for i=1:16)
  )

  return nlp
end