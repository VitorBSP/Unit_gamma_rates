using Plots, SpecialFunctions, QuadGK, LaTeXStrings
l = @layout [a ; b];

pgu = function(x,alpha,tau)
    not_kernel = (alpha^tau)/(gamma(tau))
    kernel = (x^(alpha-1))*(log(1/x))^(tau -1)
    return not_kernel*kernel
end;

pgu_integrate = function(x)
    not_kernel = (alpha^tau)/(gamma(tau))
    kernel = (x^(alpha-1))*(log(1/x))^(tau -1)
    return not_kernel*kernel
end;

x = [0.01:0.01:0.99;];
alpha = 0.5;
tau = 0.5;
integral1 = quadgk.(pgu_integrate, 0, x, rtol=1e-3);
probs1 = pgu.(x,alpha,tau);
alpha = 0.73;
integral2 = quadgk.(pgu_integrate, 0, x, rtol=1e-3);
probs2 = pgu.(x,alpha,tau);

gr(size = (1200,800));
p1 = plot(x,  probs1, legend = false, color = "#000000");
p1 = xlabel!("Suporte da Gamma Unitária");
p1 = ylabel!("Densidade");
p2 = plot(x,  probs2, legend = false, color = "#000000");
p2 = xlabel!("Suporte da Gamma Unitária");
p2 = ylabel!("Densidade");

lot(p1, p2, layout = l)

integral1 = map(x->x[1], integral1);
integral2 = getindex.(integral2, 1);

p3 = plot(x, integral1, legend = false, color = :black);
p3 = xlabel!(L"GU($\alpha$ = 0.5, $\tau$ = 0.5)");
p3 = ylabel!("Probabilidade");
p4 = plot(x,  integral2, legend = false, color = :black);
p4 = xlabel!(L"GU($\alpha$ = 0.73, $\tau$ = 0.5)");
p4 = ylabel!("Probabilidade");

plot(p3, p4, layout = l)