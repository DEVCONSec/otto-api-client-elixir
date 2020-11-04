defmodule OttoApi.Http.Behaviour do
  @callback get(String.t(), list(), list()) :: {:ok, %HTTPoison.Response{}}
  @callback delete(String.t(), list(), list()) :: {:ok, %HTTPoison.Response{}}
  @callback post(String.t(), String.t(), list(), list()) :: {:ok, %HTTPoison.Response{}}
  @callback patch(String.t(), String.t(), list(), list()) :: {:ok, %HTTPoison.Response{}}
  @callback put(String.t(), String.t(), list(), list()) :: {:ok, %HTTPoison.Response{}}
end
