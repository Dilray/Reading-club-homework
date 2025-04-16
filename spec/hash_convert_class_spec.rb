# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/hash_convert_class'

RSpec.describe HashConvertClass do 
  describe '.transform' do
    let(:input_hash) do
      {
        a: :a1,
        b: [:b1, :b2],
        c: { c1: :c2 },
        d: [:d1, [:d2, :d3], { d4: :d5 }],
        e: { e1: { e2: :e3 }, e4: [:e5, :e6] }
      }
    end

    let(:expected_output) do
      {
        a: { a1: {} },
        b: { b1: {}, b2: {} },
        c: { c1: { c2: {} } },
        d: { d1: {}, d2: {}, d3: {}, d4: { d5: {} } },
        e: { e1: { e2: { e3: {} } }, e4: { e5: {}, e6: {} } }
      }
    end

    it 'correctly transforms the hash structure' do
      expect(HashConvertClass.transform(input_hash)).to eq(expected_output)
    end

    context 'with empty input' do
      it 'returns empty hash' do
        expect(HashConvertClass.transform({})).to eq({})
      end
    end

    context 'with invalid input' do
      it 'raises error for unsupported types' do
        expect { HashConvertClass.transform({ a: 123 }) }.to raise_error(ArgumentError)
      end
    end
  end
end
