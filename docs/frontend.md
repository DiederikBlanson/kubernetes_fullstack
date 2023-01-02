# Creating a React-App with TypeScript
This guide will walk you through the process of creating a React-application with TypeScript, building a Docker container for the app, and (optionally) creating a Helm chart. The steps involved are as follows:

1. Create a React app using TypeScript
2. Dockerize the app
3. (Optional) Create a Helm chart

## Create React-App
1. Use the `create-react-app` command to create the React app with TypeScript: 
```bash
npx create-react-app my-app --template typescript
```
2. Delete `package-lock.json` and `node_modules`, then run `yarn install` to use yarn as the package manager, which creates a `yarn.lock` file.
3. Create a `config.js` file in the `/public` folder to store environment variables. We will use `window[key]` instead of `process.env[key]` to correctly inject the env variables into the Kubernetes environment.
4. Add `<script src="%PUBLIC_URL%/config.js"></script>` to `public/index.html`.
5. In `src/types`, create a file `index.d.ts` to define the types for the window variables. For example:

```
export {};
declare global {
    interface Window {
        REACT_APP_BACKEND_URL: string;
    }
}
```

## Dockerize React App
1. The `.dockerignore` file has the contents `/node_modules`. As such, `node_modules` will be ignored during the dockerization process.
2. The `Dockerfile` file consists of the image. As you can see in the `/system/frontend/app` folder, there are two Dockerfiles for both the development and production environments.

## Create Helm Chart
Normally, you don't want to create an individual Helm chart as `system/helm-run.sh` should spin up the whole environment. However, it is still possible to do so by performing the following steps:
1. Install a new chart 
```bash
microk8s helm3 install [name-chart] ./helm-chart
```
2. Uninstall the chart
```bash
microk8s helm3 uninstall [name-chart]
```

---

Sources:
- https://create-react-app.dev/docs/adding-typescript/
- https://www.knowledgehut.com/blog/web-development/how-to-dockerize-react-app
