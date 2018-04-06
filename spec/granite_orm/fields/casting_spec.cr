{% for adapter in GraniteExample::ADAPTERS %}
module {{adapter.capitalize.id}}
  describe "{{ adapter.id }} #casting_to_fields" do
    it "casts string to int" do
      model = Review.new({ "downvotes" => "32" })
      model.downvotes.should eq 32
    end

    it "generates an error if casting fails" do
      model = Review.new({ "downvotes" => "" })
      model.errors.size.should eq 1
    end

    it "compiles with empty fields" do
      model = Empty.new
      model.should_not be_nil
    end

    it "casts integer values" do
      model = Review.new(downvotes: 10_i64, upvotes: 20_i64)
      model.downvotes.should eq 10
      model.upvotes.should eq 20

      model = Review.new(downvotes: 10_i32, upvotes: 20_i32)
      model.downvotes.should eq 10
      model.upvotes.should eq 20

      model = Review.new(downvotes: 10_f32, upvotes: 20_f32)
      model.downvotes.should eq 10
      model.upvotes.should eq 20

      model = Review.new(downvotes: 10_f64, upvotes: 20_f64)
      model.downvotes.should eq 10
      model.upvotes.should eq 20
    end

    it "casts float values" do
      model = Review.new(sentiment: 30.8_f64, interest: 40.5_f64)
      model.sentiment.should eq 30.8_f32
      model.interest.should eq 40.5

      model = Review.new(sentiment: 30.8_f32, interest: 40.5_f32)
      model.sentiment.should eq 30.8_f32
      model.interest.should eq 40.5

      model = Review.new(sentiment: 30_i32, interest: 40_i32)
      model.sentiment.should eq 30_f32
      model.interest.should eq 40_f64

      model = Review.new(sentiment: 30_i64, interest: 40_i64)
      model.sentiment.should eq 30_f32
      model.interest.should eq 40_f64
    end

    it "casts not number values to number field as nil" do
      model = Review.new(
        downvotes: [] of JSON::Type,
        upvotes: [] of JSON::Type,
        sentiment: [] of JSON::Type,
        interest: [] of JSON::Type
      )
      model.downvotes.should eq nil
      model.upvotes.should eq nil
      model.sentiment.should eq nil
      model.interest.should eq nil

      model = Review.new(
        downvotes: true,
        upvotes: true,
        sentiment: true,
        interest: true
      )
      model.downvotes.should eq nil
      model.upvotes.should eq nil
      model.sentiment.should eq nil
      model.interest.should eq nil
    end
  end
end
{% end %}
