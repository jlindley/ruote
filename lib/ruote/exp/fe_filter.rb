#--
# Copyright (c) 2005-2011, John Mettraux, jmettraux@gmail.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Made in Japan.
#++

require 'ruote/util/filter'


module Ruote::Exp

  #
  # Filter is a one-way filter expression. It filters workitem fields.
  # Validations and Transformations are possible.
  #
  # There are two ways to use it. With a single rule or with an array of
  # rules.
  #
  #   filter 'x', :type => 'string'
  #     # will raise an error if the field 'x' doesn't contain a String
  #
  # or
  #
  #   filter :in => [
  #     { :field => 'x', :type => 'string' },
  #     { :field => 'y', :type => 'number' }
  #   ]
  #
  # For the remainder of this piece of documentation, the one rule filter
  # will be used.
  #
  # == validations
  #
  # TODO
  #
  # === validation errors
  #
  # TODO
  #
  # == transformations
  #
  # TODO
  #
  class FilterExpression < FlowExpression

    names :filter

    def apply

      ain = attribute_text != '' ? nil : attribute(:in)

      filter = ain || [ attributes.inject({}) { |h, (k, v)|
        if v.nil?
          h['field'] = k
        else
          h[k] = v
        end
        h
      } ]

      fields = Ruote.filter(filter, h.applied_workitem['fields'])

      reply_to_parent(h.applied_workitem.merge('fields' => fields))
    end

    def reply (workitem)

      # never called
    end
  end
end
