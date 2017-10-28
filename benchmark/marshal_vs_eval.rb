require 'benchmark/ips'

Benchmark.ips do |x|
  x.config(time: 5, warmup: 2)

  builder_eval_string = <<~EOF
    class Blog__Builder__Eval
      attr_accessor :article, :comment, :articles, :articles
    end

    Blog__Builder__Eval.new
  EOF

  class Blog__Builder__Marshal
    attr_accessor :article, :comment, :articles, :articles
  end

  dump_instance = Marshal.dump(Blog__Builder__Marshal.new)

  x.report("marshal way") {
    marshal_instance = Marshal.load(dump_instance)
  }

  x.report("eval way") {
    eval_instance = eval(dump_instance)
  }

  x.compare!
end

# Warming up --------------------------------------
#          marshal way    56.954k i/100ms
#             eval way    18.151k i/100ms
# Calculating -------------------------------------
#          marshal way    681.302k (± 4.5%) i/s -      3.417M in   5.025795s
#             eval way    198.523k (± 4.1%) i/s -    998.305k in   5.037182s
#
# Comparison:
#          marshal way:   681301.5 i/s
#             eval way:   198523.1 i/s - 3.43x  slower
