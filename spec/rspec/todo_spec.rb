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
    it "result errors if successed" do
      expect {
        not_todo { true }
      }.to raise_exception
    end

    it "results nothing" do
      not_todo { raise }
    end
  end
end
