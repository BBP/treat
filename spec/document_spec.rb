require_relative '../lib/treat'

describe Treat::Entities::Document do

  describe "Processors" do
    
    describe "#chunk" do

      context "when called on an HTML document" do
        doc = Treat::Entities::Document.new(
        Treat.spec + 'samples/mathematicians/euler.html').read(:html)
        it "splits the HTML document into sections, " +
        "titles, paragraphs and lists" do
          doc.chunk
          doc.title_count.should eql 1
          doc.title.to_s.should eql "Leonhard Euler (1707-1783)"
          doc.paragraph_count.should eql 5
        end

      end

      context "when called on an unstructured document" do

        doc = Treat::Entities::Document.new(Treat.spec +
        'samples/mathematicians/leibniz.txt').read(:txt)
        it "splits the document into titles and paragraphs" do
          doc.chunk
          doc.title_count.should eql 1
          doc.title.to_s.should eql "Gottfried Leibniz (1646-1716)"
          doc.paragraph_count.should eql 6
        end

      end

    end

  end

end

=begin

module Treat
  module Tests
    class TestFormatters < Test::Unit::TestCase

      def setup
        @doc = Treat::Tests::English::ShortDoc
        @sentence = Treat::Tests::English::Sentence
      end

      def test_readers
        # This is done by loading a collection with all types of texts.
      end

      def test_serializers_and_unserializers
        # Test roundtrip Ruby -> YAML -> Ruby -> YAML
        create_temp_file('yml') do |tmp|
          @doc.serialize(:yaml, :file => tmp)
          doc = Treat::Entities::Document(tmp)
          assert_equal File.read(tmp).length, 
          doc.serialize(:yaml).length
        end
        # Test roundtrip Ruby -> XML -> Ruby -> XML.
        create_temp_file('xml') do |tmp|
          @doc.serialize(:xml, :file => tmp)
          doc = Treat::Entities::Document(tmp)
          assert_equal File.read(tmp).length, 
          doc.serialize(:xml).length
        end
      end
      
    end
  end
end


=end