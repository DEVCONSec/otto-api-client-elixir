defmodule OttoApi.JsMonitoringJob do
  @enforce_keys [
    :site_id,
    :synthetic_check_frequency,
    :synthetic_check_location_usa,
    :synthetic_check_location_global,
    :data_retention_period_in_days
  ]
  defstruct @enforce_keys ++ [:id, :inserted_at]

  alias OttoApi.Client

  @spec all(client :: %Client{}) ::
          {:ok,
           list(%__MODULE__{
             id: binary,
             site_id: binary,
             synthetic_check_frequency: binary,
             synthetic_check_location_usa: boolean,
             synthetic_check_location_global: boolean,
             data_retention_period_in_days: integer,
             inserted_at: binary
           })}
  def all(client) do
    {:ok,
     %{
       "data" => records
     }} = Client.get(client, "/js_monitoring_jobs")

    jobs =
      Enum.map(records, fn record ->
        %{
          "id" => id,
          "site_id" => site_id,
          "synthetic_check_frequency" => synthetic_check_frequency,
          "synthetic_check_location_usa" => synthetic_check_location_usa,
          "synthetic_check_location_global" => synthetic_check_location_global,
          "data_retention_period_in_days" => data_retention_period_in_days,
          "inserted_at" => inserted_at
        } = record

        %__MODULE__{
          id: id,
          site_id: site_id,
          synthetic_check_frequency: synthetic_check_frequency,
          synthetic_check_location_usa: synthetic_check_location_usa,
          synthetic_check_location_global: synthetic_check_location_global,
          data_retention_period_in_days: data_retention_period_in_days,
          inserted_at: inserted_at
        }
      end)

    {:ok, jobs}
  end

  def create(client, job_attributes) do
    {:ok, %{"data" => job_response}} =
      Client.post(client, "/js_monitoring_jobs", %{"job" => job_attributes})

    {:ok,
     %__MODULE__{
       id: job_response["id"],
       site_id: job_response["site_id"],
       synthetic_check_frequency: job_response["synthetic_check_frequency"],
       synthetic_check_location_usa: job_response["synthetic_check_location_usa"],
       synthetic_check_location_global: job_response["synthetic_check_location_global"],
       data_retention_period_in_days: job_response["data_retention_period_in_days"],
       inserted_at: job_response["inserted_at"]
     }}
  end
end
