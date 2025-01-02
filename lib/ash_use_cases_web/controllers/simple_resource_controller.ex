defmodule AshUseCasesWeb.SimpleResourceController do
  use AshUseCasesWeb, :controller

  alias AshUseCases.NoRelationship.SimpleResource

  def index(conn, _params) do
    simpleresources = SimpleResource.read!()
    render(conn, :index, simpleresources: simpleresources)
  end

  def new(conn, _params) do
    render(conn, :new, form: create_form())
  end

  def create(conn, %{"simple_resource" => simple_resource_params}) do
    simple_resource_params
    |> create_form()
    |> AshPhoenix.Form.submit()
    |> case do
      {:ok, simple_resource} ->
        conn
        |> put_flash(:info, "SimpleResource created successfully.")
        |> redirect(to: ~p"/simpleresources/#{simple_resource}")

      {:error, form} ->
        conn
        |> put_flash(:error, "SimpleResource could not be created.")
        |> render(:new, form: form)
    end
  end

  def show(conn, %{"id" => id}) do
    simple_resource = SimpleResource.by_id!(id)
    render(conn, :show, simple_resource: simple_resource)
  end

  def edit(conn, %{"id" => id}) do
    simple_resource = SimpleResource.by_id!(id)

    render(conn, :edit, simple_resource: simple_resource, form: update_form(simple_resource))
  end

  def update(conn, %{"simple_resource" => simple_resource_params, "id" => id}) do
    simple_resource = SimpleResource.by_id!(id)

    simple_resource
    |> update_form(simple_resource_params)
    |> AshPhoenix.Form.submit()
    |> case do
      {:ok, simple_resource} ->
        conn
        |> put_flash(:info, "SimpleResource updated successfully.")
        |> redirect(to: ~p"/simpleresources/#{simple_resource}")

      {:error, form} ->
        conn
        |> put_flash(:error, "SimpleResource could not be updated.")
        |> render(:edit, simple_resource: simple_resource, form: form)
    end
  end

  def delete(conn, %{"id" => id}) do
    simple_resource = SimpleResource.by_id!(id)
    :ok = SimpleResource.destroy(simple_resource)

    conn
    |> put_flash(:info, "SimpleResource deleted successfully.")
    |> redirect(to: ~p"/simpleresources")
  end

  defp create_form(params \\ nil) do
    AshPhoenix.Form.for_create(SimpleResource, :create, as: "simple_resource", params: params)
  end

  defp update_form(simple_resource, params \\ nil) do
    AshPhoenix.Form.for_update(simple_resource, :update, as: "simple_resource", params: params)
  end
end
