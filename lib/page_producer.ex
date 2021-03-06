# ---
# Excerpted from "Concurrent Data Processing in Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/sgdpelixir for more book information.
# ---
defmodule PageProducer do
  use GenStage
  require Logger

  def start_link(_args) do
    initial_state = []
    GenStage.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(initial_state) do
    Logger.info("PageProducer init")
    {:producer, initial_state}
  end

  def handle_demand(demand, state) do
    Logger.info("PageProducer received demand for #{demand} pages")
    events = []
    {:noreply, events, state}
  end

  def scrape_pages(pages) when is_list(pages) do
    GenStage.cast(__MODULE__, {:pages, pages})
  end

  def handle_cast({:pages, pages}, state) do
    {:noreply, pages, state}
  end
end

# Commands
# PageProducer.scrape_pages(pages)
