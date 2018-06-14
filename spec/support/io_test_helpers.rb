require 'stringio'

module IoTestHelpers
  def simulate_stdin(*inputs, &block)
    $stdin = StringIO.new
    inputs.flatten.each { |str| $stdin.puts(str) }
    $stdin.rewind
    yield
  ensure
    $stdin = STDIN
  end
end

RSpec.configure do |conf|
  conf.include(IoTestHelpers)
end