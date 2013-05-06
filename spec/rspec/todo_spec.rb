require "spec_helper"

describe "rspec-todo" do
  context "todo" do
    context "with description" do
      it "becomes pending if failed" do
        todo("will raise hoge") { raise "hoge" }
      end
    end

    context "without description" do
      it "passes" do
        todo { true }
      end

      it "becomes pending if failed" do
        todo { raise "hoge" }
      end
    end
  end

  context "not todo" do
    it "result error if successed" do
      expect {
        not_todo { true }
      }.to raise_exception
    end

    it "results nothing when expectation not matched" do
      not_todo { 1.should == 2 }
    end

    it "results nothing when specified error occured" do
      not_todo("runtime error occured", RuntimeError) do
        raise
      end
    end

    it "results error if runtime error occured" do
      expect {
        not_todo { raise }
      }.to raise_exception
    end
  end
end
