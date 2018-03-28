require "../../spec_helper"

{% for adapter in GraniteExample::ADAPTERS %}
module {{adapter.capitalize.id}}
  describe "{{ adapter.id }} association destroy_all" do
    it "destroys all associated records" do
      teacher = Teacher.create(name: "test teacher")
      Klass.create(name: "Test class 1", teacher_id: teacher.id)
      Klass.create(name: "Test class 2", teacher_id: teacher.id)

      teacher.klasss.size.should eq 2
      teacher.klasss.destroy_all
      teacher.klasss.size.should eq 0
    end
  end

  describe "{{ adapter.id }} association find_each" do
    it "destroys all associated records" do
      teacher = Teacher.create(name: "test teacher")
      klass1 = Klass.create(name: "Test class 1", teacher_id: teacher.id)
      klass2 = Klass.create(name: "Test class 2", teacher_id: teacher.id)

      unrelated_teacher = Teacher.create(name: "test teacher")
      Klass.create(name: "Test class 2", teacher_id: unrelated_teacher.id)

      results = [] of Int64

      teacher.klasss.find_each do |klass|
        results << klass.id
      end

      results.sort.should eq [klass1.id, klass2.id]
    end
  end
end
{% end %}
