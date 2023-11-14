
clear;
close all;
clc;


% PARTIE I

% Question 2 

x = rand(1000, 1);
h = [1 0.3 -0.1 0.2]';
d = conv(x, h);

% figure
% subplot(1, 2, 1)
% plot(x)
% title("Signal x")
% subplot(1, 2, 2)
% plot(d)
% title("Signal d")


% Question 4 

[w, y, e] = algoms(x, d, 4, 0.1);

% figure
% plot(d)
% hold on
% plot(y)
% hold on
% plot(e)
% hold off
% title("Signaux y, d et l'erreur en fonction du temps")
% legend("Signal d", "Signal y", "erreur")


% Question 5

[w, y, e1] = algoms(x, d, 4, 0.01);
[w, y, e2] = algoms(x, d, 4, 0.1);
[w, y, e3] = algoms(x, d, 4, 1);

% figure
% plot(e1)
% hold on
% plot(e2)
% hold on
% plot(e3)
% hold off
% title("Erreur pour P = 4 et différentes valeures de mu")
% legend("mu = 0.01", "mu = 0.1", "mu = 0.5")

[w, y, e1] = algoms(x, d, 20, 0.1);
[w, y, e2] = algoms(x, d, 10, 0.1);
[w, y, e3] = algoms(x, d, 5, 0.1);

% figure
% plot(e1)
% hold on
% plot(e2)
% hold on
% plot(e3)
% hold off
% title("Erreur pour mu = 0.1 et différentes valeures de P")
% legend("P = 20", "P = 10", "P = 5")



% PARTIE II

% Question 1

[une_voix, fs] = audioread('Voix1.wav');
t = (0:length(une_voix)-1)/fs;

data = importdata('Rep.dat');
d = conv(une_voix, data);
bruit_voix = rand(length(d), 1);
d_bruite = d + bruit_voix; % Notre signal dans la pièce et bruité
t1 = (0:length(d)-1)/fs;

une_voix_padding = [une_voix; zeros(length(d)-length(une_voix), 1)]; %Zeros padding à la fin pour completer

[w, y, e] = algoms(d_bruite, une_voix_padding, 150, 0.01);

%sound(d_bruite, fs)
%sound(y, fs)

% figure
% plot(t1, d_bruite)
% hold on
% plot(t1, une_voix_padding)
% hold on
% plot(t1, y)
% hold on
% plot(t1, e)
% hold off
% title("Signaux de la voix avant et après le filtre")
% legend("Voix dans la pièce et bruité", "Voix de base", "Voix filtré", "erreur")


% Question 2

[x, fs1] = audioread('s1.wav');
[v, fs2] = audioread('s2.wav');
x_loin = conv(x, data); % La voie la plus éloignée
x = [x; zeros(length(x_loin)-length(v), 1)];
v = [v; zeros(length(x_loin)-length(v), 1)];

t1 = (0:length(x)-1)/fs1;

%sound(x, fs1)
%sound(v, fs2)
%sound(x_loin, fs1)

% Superpose les 2 voix
dialogue_opti = x + v;
dialogue = x_loin + v; 

%sound(dialogue, fs1)

[w, y, e] = algoms(dialogue, dialogue_opti, 300, 0.001);

figure
plot(t1, dialogue)
hold on
plot(t1, dialogue_opti)
hold on
plot(t1, y)
% hold on
% plot(t1, e)
hold off
title("Signaux du dialogue avant et après le filtrage")
legend("Dialogue dans la pièce", "Dialogue de  base", "Dialogue filtré et amélioré")




