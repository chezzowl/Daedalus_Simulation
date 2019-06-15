function [ file ] = initFile()
%INITFILE initialization of the mat file
%   function, returning the mat file, which is containing
%   all values we need during propagation

%seed start values
globals = GlobalDefs.getInstance;
globals.init(globals);

%changeable number of blade elements
%adjustment of simulation speed possible
bladeElems = 50;

%create wings
wing1 = Wings(0,bladeElems , globals);
wing2 = Wings(pi/2, bladeElems , globals);
wing3 = Wings(pi, bladeElems , globals);
wing4 = Wings((3*pi)/2, bladeElems , globals);

wingArray = [wing1, wing2, wing3, wing4];

%initialize all arrays
arrays = ArrayStorage.getInstance;

%velocity object
v = Velocity;

%other storages
aero = Aerodynamics;
atm = Atmosphere;
pos = Position(0, 0, 75000);%% start alt.
refs = ReferenceValues;
windData = WindData;

forces = Forces;

%matrix = Matrix('GOE.txt');

%matrices, depending on Re - number

%matrix for Re = 50000
matrix50 = Matrix('Matrices_NACA\NACARE50000Correct.txt');

%matrix for Re = 100000
matrix100 = Matrix('Matrices_NACA\NACARE100000Correct.txt');

%matrix for Re = 200000
matrix200 = Matrix('Matrices_NACA\NACARE200000Correct.txt');

%TEMPORARY

%file creation
matfile('bla.mat');
save('bla.mat', 'globals','wingArray', 'arrays', 'v', 'aero', 'atm','forces', 'pos', 'refs', 'windData', 'matrix50', 'matrix100','matrix200');
file = load('bla.mat');




end

