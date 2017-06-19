task :rspec do
  env_args = {
    :concurrency => ENV['concurrency'],
    :spec_files => ENV['specs']
  }

  default_args = {
    :concurrency => 20,
    :files => 'lib/features'
  }

  concurrency = env_args[:concurrency]    || default_args[:concurrency]
  spec_files = env_args[:spec_files]      || default_args[:files]

  parallel_arguments = %W(--type rspec -n #{concurrency})

  if ENV['test_options']
    parallel_arguments.push '-o'
    parallel_arguments.push ENV['test_options']
  end

  spec_files.split(',').each { |file| parallel_arguments.push file }

  ParallelTests::CLI.new.run(parallel_arguments)
end
