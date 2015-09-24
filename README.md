# ruby-and-r-example
A demo on how to invoke R models/instructions on a remote R server with Ruby

## How to run this demo:

This demo was made to work on any system/workstation using Docker + Compose:
 - If your'e using Mac or Windows, please install [Docker Toolbox](https://www.docker.com/toolbox), and then [create a machine with Docker Machine](https://docs.docker.com/machine/get-started/).
 - If your'e brave and use Linux, please [install Docker](https://docs.docker.com/installation/) & [Docker Compose](https://docs.docker.com/compose/).

### 1: Clone the project:

```bash
git clone git@github.com:vovimayhem/ruby-and-r-example.git randr && cd randr
```

### 2: Start just the R engine host

```bash
docker-compose up -d engine
```

### 3: Run the interactive ruby client

The first time you run this command, you'll see a bunch of commands while Compose
builds a development image of the example code:

```bash
docker-compose run --rm client
```

Once you see the ruby pry console prompt, you can use the following ruby commands:

```ruby
# Require the example class:
require './example'

# Initialize an example object, which will start a connection to the R host:
ex = Example.new

# Do a sum remotely on the R host:
ex.sum_on_r 1,2,3,4,5
# => 15

# Use the example object's connection to try out more stuff on the R host:
expr = ex.conn.eval 'x<-rnorm(1)'
puts expr.to_ruby

expr = ex.conn.eval 'list(first_name="John", last_name="Doe")'
puts expr.to_ruby

# Assign a vector (array) to a remote variable called 'x':
ex.conn.assign 'x', Rserve::REXP::Double.new([1.5,2.3,5])

# And then sum it remotely:
expr = ex.conn.eval 'sum(x)'

# And convert the expression back to ruby:
expr.to_ruby
```
