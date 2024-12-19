
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app


EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80
ENV ASPNETCORE_ENVIRONMENT Development


FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src


COPY ["Api_lamoda/Api_lamoda.csproj", "Api_lamoda/"]



RUN dotnet restore "Api_lamoda/Api_lamoda.csproj"


COPY . .


FROM build AS publish
RUN dotnet publish "Api_lamoda/Api_lamoda.csproj" -c Release -o /app/publish /p:UseAppHost=false


FROM base AS final
WORKDIR /app


COPY --from=publish /app/publish .


ENTRYPOINT ["dotnet", "Api_lamoda.dll"]