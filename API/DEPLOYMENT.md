# Render Deployment Guide

## Prerequisites
- GitHub repository with your API code
- Render account (free)

## Deployment Steps

### 1. Prepare Your Repository
Ensure your API folder contains:
- `main.py` (FastAPI app)
- `requirements.txt` (dependencies)
- `Procfile` (start command)
- `runtime.txt` (Python version)
- All `.pkl` model files

### 2. Deploy on Render

1. **Go to Render Dashboard**
   - Visit [render.com](https://render.com)
   - Sign up/Login with GitHub

2. **Create New Web Service**
   - Click "New +"
   - Select "Web Service"
   - Connect your GitHub repository

3. **Configure Service**
   - **Name:** `pcos-prediction-api`
   - **Environment:** `Python 3`
   - **Build Command:** `pip install -r requirements.txt`
   - **Start Command:** `uvicorn main:app --host 0.0.0.0 --port $PORT`

4. **Environment Variables (Optional)**
   - Add any environment variables if needed

5. **Deploy**
   - Click "Create Web Service"
   - Wait for build to complete

### 3. Update Your Flutter App
Update the API URL in your Flutter app to:
```
https://your-service-name.onrender.com
```

### 4. Test the Deployment
1. Visit your service URL
2. Check `/docs` for Swagger UI
3. Test the `/predict` endpoint

## Important Notes

### Render Free Plan Limitations
- **Sleep Mode:** Service sleeps after 15 minutes of inactivity
- **Wake-up Time:** First request after sleep takes ~45 seconds
- **Monthly Hours:** 750 free hours per month

### Handling Sleep Mode
Your Flutter app now includes:
- **Loading indicators** during wake-up
- **Timeout handling** (60 seconds)
- **User-friendly messages** about delays
- **Automatic retry logic**

### Monitoring
- Check Render dashboard for service status
- Monitor logs for any errors
- Set up alerts if needed

## Troubleshooting

### Common Issues
1. **Build Fails:** Check `requirements.txt` and Python version
2. **Import Errors:** Ensure all `.pkl` files are in the repository
3. **Timeout Errors:** Normal for free plan, handled in app
4. **CORS Issues:** Already configured in `main.py`

### Performance Tips
- Consider upgrading to paid plan for production
- Implement caching if needed
- Monitor usage to stay within free limits 