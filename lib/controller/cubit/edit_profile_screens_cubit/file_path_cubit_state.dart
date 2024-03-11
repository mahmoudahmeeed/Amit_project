part of 'file_path_cubit.dart';

abstract class FilePathCubitState {}

class FilePathCubitInitialState extends FilePathCubitState {}

// !----------------------------------------! //

class ImageFilePathCubitState extends FilePathCubitState {}

class PortfolioCubitState extends FilePathCubitState {}

// !----------------------------------------! //

class PortfolioUploadCubitLoadingState extends FilePathCubitState {}

class PortfolioUploadCubitCompleteState extends FilePathCubitState {}

class PortfolioUploadCubitErrorState extends FilePathCubitState {}

// !----------------------------------------! //

class PortfolioDownloadCubitLoadingState extends FilePathCubitState {}

class PortfolioDownloadCubitCompleteState extends FilePathCubitState {}

class PortfolioDownloadCubitErrorState extends FilePathCubitState {}

// !----------------------------------------! //

class SelectedFilePathCubitState extends FilePathCubitState {}

class SelectFileCubitState extends FilePathCubitState {}

// !-------------------------------------------!//
class SelectedFileLoadingCubitState extends FilePathCubitState {}

class SelectedFileSuccessCubitState extends FilePathCubitState {}

class SelectedFileErrorCubitState extends FilePathCubitState {}
