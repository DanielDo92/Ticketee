RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:deletion)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.around(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :deletion : :transaction

    DatabaseCleaner.cleaning do
      example.run
    end

  end
end