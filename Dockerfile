FROM ruby:2.2.3

RUN mkdir /code
WORKDIR /code
ADD Gemfile /code/
RUN bundle install
ADD . /code/
CMD ["python", "clock.py"]