IF NOT EXIST "Vespucci\release\libgcc_s_seh-1.dll" copy /y "..\Vespucci_dependencies\DLL\libgcc_s_seh-1.dll" "Vespucci\release"
IF NOT EXIST "Vespucci\release\libgfortran-3.dll" copy /y "..\Vespucci_dependencies\DLL\libgfortran-3.dll" "Vespucci\release"
IF NOT EXIST "Vespucci\release\libopenblas.dll" copy /y "..\Vespucci_dependencies\DLL\libopenblas.dll" "Vespucci\release"
IF NOT EXIST "Vespucci\release\libquadmath-0.dll" copy /y "..\Vespucci_dependencies\DLL\libquadmath-0.dll" "Vespucci\release"
IF NOT EXIST "Vespucci\release\lapack_x64.dll" copy /y "..\Vespucci_dependencies\DLL\lapack_x64.dll"
copy /y "VespucciLibrary\release\vespucci.dll" "Vespucci\release"