require_relative "../lib/cli.rb"

describe CLI do
  context "when game is started" do
    it "prints welcome message to console" do
      expect { CLI.new }.to output(/W E L C O M E/).to_stdout
    end
    
    it "creates a Game object" do
      expect(CLI.new.game).to be_a(Game)
    end
  end
end