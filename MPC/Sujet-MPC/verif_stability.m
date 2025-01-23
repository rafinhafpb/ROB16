function ok=verif_stability(x_verif)
  try
    pkg load control
    pkg load instrument-control
  end
  %parametres
  mu=0.5;
  u0=0;
  x10=0;
  x20=0;

  %matrice de poids
  Q=[0.5,0;0,0.5];
  R=[1];

  %linéarisés jacobienne
  A=[u0*(1-mu), 1; 1, -u0*4*(1-mu)];

  B=[mu+(1-mu)*x10; mu-4*(1-mu)*x20];

  %essai riccati : A'P+PA-PB inv(R) B'P + Q =0
  [x, l, g] = care (A, B, Q, R);
  K=-g;
  disp(K)

  %systeme rebouclage
  Ak = A + B*K;
  M=[-1,0;0,-1] - (Ak);

  %calcul de la borne, on retrouve bien celle de l'article
  lambda=-max(eigs(Ak));
  % borne a 95 %
  alpha=lambda-0.05*lambda;

  %matrice pour equation lyap
  Al=(Ak + [alpha, 0; 0, alpha])';
  Bl=(Q+K'*R*K);

  P=lyap(Al,Bl);
  disp(P)

  options = optimset('MaxIter', 1000, 'TolX', 1e-4);

  %ici on calcul la borne du problème quadratique beta
  [x1,obj]=qp([0.5;0.5],-2*P,[],[],[],[-0.8;-0.8],[0.8;0.8],-2,K,2,options)
  beta=-obj

  %test qui valide ou non si le point est dans la zone de stabilité du controleur
  test = x_verif'*P*x_verif
  ok = (test < beta)


endfunction
