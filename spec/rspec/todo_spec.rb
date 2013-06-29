require "spec_helper"

shared_examples "pending" do |sub_description, opts = {}|
  context(sub_description, opts) do
    it "works" do
      begin
        expect { expectation }.to raise_exception(pending_exception)
      ensure
        # if not example comes to be pending and cannot determine green or red
        example.metadata[:pending] = false
      end
    end
  end
end

shared_examples "being passed" do |sub_description, opts = {}|
  context(sub_description, opts) do
    it "works" do
      expectation
    end
  end
end

shared_examples "error" do |sub_description, opts = {}|
  context(sub_description, opts) do
    it "works" do
      begin
        expect { expectation }.to raise_exception {|exception|
          exception.should_not be_a(pending_exception)
        }
      ensure
        # if not example may come to be pending and cannot detect failre
        example.metadata[:pending] = false
      end
    end
  end
end

describe "rspec-todo" do
  let(:pending_exception) { ::RSpec::Core::Pending::PendingDeclaredInExample }

  context "#rspec_todo_works_for" do
    [ [ true,  true,  true ],
      [ true,  false, true ],
      [ true,  nil,   true ],
      [ false, true,  false ],
      [ false, false, true ],
      [ false, nil,   false ],
      [ nil,   true,  false ],
      [ nil,   false, true ],
      [ nil,   nil,   true ],
    ].each do |if_value, unless_value, result|
      it "returns #{result} when if is #{if_value.inspect} and unless is #{unless_value.inspect}" do
        rspec_todo_works_for(if: if_value, unless: unless_value).should == result
      end
    end
  end

  context "todo" do
    context "with description" do
      it_behaves_like "pending", "when expectation failed" do
        let(:expectation) do
          todo("with raise hoge") { raise "hoge" }
        end
      end
    end

    context "without description" do
      it_behaves_like "being passed", "when expectation succeeded" do
        let(:expectation) do
          todo { true }
        end
      end

      it_behaves_like "pending", "when expectation failed" do
        let(:expectation) do
          todo { raise "hoge" }
        end
      end
    end

    context "with if opts" do
      context "are true" do
        it_behaves_like "being passed", "when expectation succeeded" do
          let(:expectation) do
            todo(if: true) { true }
          end
        end

        it_behaves_like "pending", "when expectation failed" do
          let(:expectation) do
            todo(if: true) { raise "hoge" }
          end
        end
      end

      context "are false" do
        it_behaves_like "being passed", "when expectation succeeded" do
          let(:expectation) do
            todo(if: false) { true }
          end
        end

        it_behaves_like "error", "when expectation failed" do
          let(:expectation) do
            todo(if: false) { raise "hoge" }
          end
        end
      end
    end

    context "with unless opts" do
      context "are false" do
        it_behaves_like "being passed", "when expectation succeeded" do
          let(:expectation) do
            todo(unless: false) { true }
          end
        end

        it_behaves_like "pending", "when expectation failed" do
          let(:expectation) do
            todo(unless: false) { raise "hoge" }
          end
        end
      end

      context "are true" do
        it_behaves_like "being passed", "when expectation succeeded" do
          let(:expectation) do
            todo(unless: true) { true }
          end
        end

        it_behaves_like "error", "when expectation failed" do
          let(:expectation) do
            todo(unless: true) { raise "hoge" }
          end
        end
      end
    end
  end

  context "not todo" do
    it_behaves_like "error", "when succeeded" do
      let(:expectation) do
        not_todo { true }
      end
    end

    it_behaves_like "being passed", "when expectation not matched" do
      let(:expectation) do
        not_todo { 1.should == 2 }
      end
    end

    context "when expectation raise exception" do
      it_behaves_like "being passed", "when error is specified" do
        let(:expectation) do
          not_todo("runtime error occured", errors: RuntimeError) do
            raise
          end
        end
      end

      it_behaves_like "being passed", "when errors are specified" do
        let(:expectation) do
          not_todo("runtime error occured", errors: [ RuntimeError ]) do
            raise
          end
        end
      end

      it_behaves_like "error", "when errors are not specified" do
        let(:expectation) do
          not_todo { raise "unexpected" }
        end
      end
    end

    context "with if opts" do
      context "are true" do
        it_behaves_like "error", "when expectation succeeded" do
          let(:expectation) do
            not_todo(if: true) { true }
          end
        end

        it_behaves_like "being passed", "when expectation failed" do
          let(:expectation) do
            not_todo(if: true) { 1.should == 2 }
          end
        end

        it_behaves_like "being passed", "when errors are specified" do
          let(:expectation) do
            not_todo(if: true, errors: RuntimeError) { raise }
          end
        end
      end

      context "are false" do
        it_behaves_like "being passed", "when expectation succeeded" do
          let(:expectation) do
            not_todo(if: false) { true }
          end
        end

        it_behaves_like "error", "when expectation failed" do
          let(:expectation) do
            not_todo(if: false) { 1.should == 2 }
          end
        end

        it_behaves_like "error", "even if errors are specified" do
          let(:expectation) do
            not_todo(if: false, errors: RuntimeError) { raise }
          end
        end
      end
    end

    context "with unless opts" do
      context "are false" do
        it_behaves_like "error", "when expectation succeeded" do
          let(:expectation) do
            not_todo(unless: false) { true }
          end
        end

        it_behaves_like "being passed", "when expectation failed" do
          let(:expectation) do
            not_todo(unless: false) { 1.should == 2 }
          end
        end

        it_behaves_like "being passed", "when errors are specified" do
          let(:expectation) do
            not_todo(unless: false, errors: RuntimeError) { raise }
          end
        end
      end

      context "are true" do
        it_behaves_like "being passed", "when expectation succeeded" do
          let(:expectation) do
            not_todo(unless: true) { true }
          end
        end

        it_behaves_like "error", "when expectation failed" do
          let(:expectation) do
            not_todo(unless: true) { 1.should == 2 }
          end
        end

       it_behaves_like "error", "even if errors are specified" do
          let(:expectation) do
            not_todo(unless: true, errors: RuntimeError) { raise }
          end
        end
      end
    end
  end
end
