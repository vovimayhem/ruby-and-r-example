FROM vovimayhem/app-dev:mri-2.2.3

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

# Run 'bundle install'
RUN bundle install

ENV BUNDLE_CONSOLE pry

CMD ["bundle", "console"]
