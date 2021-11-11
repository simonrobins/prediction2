# Prediction2

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

Predictions:

 fixture_id |    date    | home_id |   name    | away_id |  name   | prediction_id | result 
------------+------------+---------+-----------+---------+---------+---------------+--------
          2 | 2021-08-13 |       3 | Brentford |       1 | Arsenal |               |       
(1 row)

user_id
date home away result prediction

\copy fixtures (date, home, away) from fixtures.csv with csv

select * from fixtures f left join predictions p on f.id = p.fixture_id and user_id = 4 order by f.id;

query = Ecto.Query.from f in "fixtures", left_join: p in "predictions", on: f.id == p.fixture_id and p.user_id == 4, order_by: f.date, select: %{fixture_id: f.id, date: f.date, home: f.home, away: f.away, result: f.result, prediction_id: p.id, prediction: p.result}

Prediction2.Repo.all(query)

 id  |    date    |      home       |      away       | result | id | result | user_id | fixture_id 
-----+------------+-----------------+-----------------+--------+----+--------+---------+------------
   1 | 2021-08-13 | Brentford       | Arsenal         |        |  6 | H      |       4 |          1
   2 | 2021-08-14 | Burnley         | Brighton        |        |  7 | H      |       4 |          2
   3 | 2021-08-14 | Chelsea         | Crystal Palace  |        |  5 | H      |       4 |          3
   4 | 2021-08-14 | Everton         | Southampton     |        |    |        |         |           
   5 | 2021-08-14 | Leicester City  | Wolves          |        |    |        |         |           
   6 | 2021-08-14 | Manchester Utd  | Leeds United    |        |    |        |         |           
   7 | 2021-08-14 | Norwich City    | Liverpool       |        |    |        |         |           
   8 | 2021-08-14 | Watford         | Aston Villa     |        |    |        |         |           
   9 | 2021-08-15 | Newcastle Utd   | West Ham        |        |    |        |         |           
