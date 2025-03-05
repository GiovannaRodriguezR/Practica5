
L = 2e-3;   % Inductancia en Henrios (2 mH)
R = 10;     % Resistencia en Ohmios (10 Ω)
C = 10e-6;  % Capacitancia en Faradios (10 µF)
Vin = 32;   % Voltaje de entrada en Voltios (32 V)
D = 0.4;    % Ciclo de trabajo del 40%

x0 = [0; 0]; % iL(0) = 0, Vc(0) = 0

tspan = [0 0.01]; 

[t, x] = ode45(@(t, x) state_space(t, x, L, C, R, Vin, D), tspan, x0);

figure;
plot(t, x(:,1), 'b', 'LineWidth', 1.5, 'DisplayName', 'Corriente i_L'); % Corriente
hold on;
plot(t, x(:,2), 'r', 'LineWidth', 1.5, 'DisplayName', 'Voltaje V_c');   % Voltaje
hold off;

xlabel('Tiempo (s)');
ylabel('Magnitud');
grid on;
title('Corriente en el inductor y voltaje en el capacitor');
legend('show'); % Leyenda para identificar cada curva

function dx = state_space(t, x, L, C, R, Vin, D)
    % Señal PWM: Aproximación como un promedio basado en el ciclo de trabajo
    d = D; % Valor fijo para simplificación
    
    % Matriz del sistema
    A = [0, -1/L; 1/C, -1/(R*C)];
    B = [Vin/L; 0];
    
    % Ecuaciones de estado
    dx = A*x + B*d;
end
