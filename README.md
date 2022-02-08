# Brightwheel-Api

For this exercise, imagine that we have devices that record an integer at arbitrary intervals called “readings.” These readings are then sent out over the internet as HTTP requests. We would like you to implement a simple web API that receives these requests.

## How to use

1. Clone this repository: `git@github.com:axelpontetto/brightwheel-api.git`
1. Create the database: `rails db:create && rails db:migrate`
1. Run `rspec` to check all tests are passing
1. Run the server: `rails s`
1. You can start making requests

## Api Docs

<table>
    <thead>
        <tr>
            <th>API</th>
            <th>HTTP verb</th>
            <th>URI</th>
            <th>Request Parameters</th>
            <th>Response</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Readings</td>
            <td>POST</td>
            <td><i>/readings</i></td>
            <td><i><b>uuid</b></i> (uuid), <i><b>readings:</b></i> [<i><b>timestamp</b></i> (date), <i><b>count</b></i> (integer)]</td>
            <td><b>Success</b>: return 200 code with the readings that were created.<br>
                <b>Failure</b>: return HTTP error code with error description.</td>
        </tr>
        <tr>
            <td>Devices</td>
            <td>GET</td>
            <td><i>/devices/{uuid}</i></td>
            <td><i><b>uuid</b></i> (uuid)</td>
            <td><b>Success</b>: return 200 code with the cumulative count and most recent reading for the given device.<br>
                <b>Failure</b>: return HTTP error code with error description.</td>
        </tr>
    </tbody>
</table>

## Design decisions

1. The coding challenge says not to use a database, but I need a way to store the devices and readings in order to be able to return the cumulative and most recent reading for a given device. Since it wasn't possible to clarify this requirement before doing the challenge I decided to use sqlite. There are several options if sqlite isn't allowed, for example: Redis (database in memory) or AWS / Google Cloud / Azure.

1. According to the requirements, the input could be malformed, but since I added validations to the models I think it's not necessary to create an extra service to validate the input itself. In the case we must validate the input because some specific reason I can use the dry-validation gem, so that I can validate the json schema before processing it.

1. Since it's not specified I decided to create the device if it doesn't exist before creating the readings.

1. In the device table add added a string field called uuid to simplify things. If that's not enough I could replace the original id with an uuid.

## Anything you would have included given more time

1. Code coverage
1. Github actions
1. Deploy to heroku
1. Despite the fact it's out of scope I would add:
* Authentication using JWT (Json Web Tokens)
* UI to use the api
