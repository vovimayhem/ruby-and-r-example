require 'rserve'

class Example
  attr_reader :conn

  # Example initializer, connects to the remote R host specified in the
  # ENGINE_URL environment variable:
  def initialize
    engine_uri = URI(ENV.fetch 'ENGINE_URL')
    @conn = Rserve::Connection.new hostname: engine_uri.host
  end

  # Returns the sum of given parameters by assigning the parameters to a variable
  # in the R shell, summing the remotely on the R shell, and receiving the
  # result back to the ruby process:
  def sum_remotely(*input_array)
    # Assign the input array to a variable in the remote R host:
    conn.assign "x", input_array

    # Print on the R Host something, so we can see on the Rserve logs
    # that communication is indeed happening:
    conn.eval 'print(cat("Summing a vector provided by client: ", x, "."))'

    # Return the sum of the array done on the remote R Host:
    conn.eval("sum(x)").to_ruby
  end

end
