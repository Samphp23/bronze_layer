FROM public.ecr.aws/aws-glue/aws-glue-libs:glue_libs_5.0.0_image_01

# Set working directory
WORKDIR /app

# Copy your Glue script into container
COPY . /app

# Entry point to run your Glue script
CMD ["python", "bronze_layer.py"]
